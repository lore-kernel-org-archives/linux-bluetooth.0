Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Apple Message framework v1082)
Subject: Re: [PATCH v2] Implement ATT handle indications
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1298646072-28812-1-git-send-email-epx@signove.com>
Date: Fri, 4 Mar 2011 15:36:12 -0300
Message-Id: <328D9FD2-B104-4AC3-AFB0-9699D7F77E03@signove.com>
References: <1298646072-28812-1-git-send-email-epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just a reminder that this patch needs review.

On 25 Feb 2011, at 12:01 , Elvis Pfützenreuter wrote:

> ---
> src/attrib-server.c |   69 +++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 69 insertions(+), 0 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 5f645bb..f683707 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -54,6 +54,8 @@ struct gatt_channel {
> 	GSList *configs;
> 	GSList *notify;
> 	GSList *indicate;
> +	gboolean outstanding_indication;
> +	GSList *pending_indications;
> 	GAttrib *attrib;
> 	guint mtu;
> 	guint id;
> @@ -770,12 +772,58 @@ static void channel_disconnect(void *user_data)
> 
> 	g_slist_free(channel->notify);
> 	g_slist_free(channel->indicate);
> +	g_slist_free(channel->pending_indications);
> 	g_slist_foreach(channel->configs, (GFunc) g_free, NULL);
> 	g_slist_free(channel->configs);
> 
> 	g_free(channel);
> }
> 
> +static void attrib_resume_indications(struct gatt_channel *channel);
> +
> +static void attrib_indicate_client_cb(guint8 status, const guint8 *pdu,
> +					guint16 len, gpointer user_data)
> +{
> +	struct gatt_channel *channel = user_data;
> +
> +	if (status)
> +		return;
> +
> +	attrib_resume_indications(channel);
> +}
> +
> +static void attrib_indicate_client(struct gatt_channel *channel,
> +					struct attribute *attr)
> +{
> +	uint8_t pdu[ATT_MAX_MTU];
> +	uint16_t len;
> +
> +	len = enc_indication(attr, pdu, channel->mtu);
> +	if (len == 0)
> +		return;
> +
> +	channel->outstanding_indication = TRUE;
> +
> +	g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
> +		attrib_indicate_client_cb, channel, NULL);
> +}
> +
> +static void attrib_resume_indications(struct gatt_channel *channel)
> +{
> +	struct attribute *a;
> +
> +	channel->outstanding_indication = FALSE;
> +
> +	if (!channel->pending_indications)
> +		return;
> +
> +	a = channel->pending_indications->data;
> +	channel->pending_indications =
> +		g_slist_remove(channel->pending_indications, a);
> +
> +	attrib_indicate_client(channel, a);
> +}
> +
> static void channel_handler(const uint8_t *ipdu, uint16_t len,
> 							gpointer user_data)
> {
> @@ -872,6 +920,8 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
> 		length = find_by_type(start, end, &uuid, value, vlen,
> 							opdu, channel->mtu);
> 		break;
> +	case ATT_OP_HANDLE_CNF:
> +		return;
> 	case ATT_OP_READ_MULTI_REQ:
> 	case ATT_OP_PREP_WRITE_REQ:
> 	case ATT_OP_EXEC_WRITE_REQ:
> @@ -948,6 +998,15 @@ static void confirm_event(GIOChannel *io, void *user_data)
> 	return;
> }
> 
> +static void attrib_sched_indication(struct gatt_channel *channel,
> +							struct attribute *a)
> +{
> +	if (!g_slist_find_custom(channel->pending_indications, a,
> +							attribute_cmp))
> +		channel->pending_indications =
> +			g_slist_append(channel->pending_indications, a);
> +}
> +
> static void attrib_notify_clients(struct attribute *attr)
> {
> 	guint handle = attr->handle;
> @@ -969,6 +1028,15 @@ static void attrib_notify_clients(struct attribute *attr)
> 			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
> 							NULL, NULL, NULL);
> 		}
> +
> +		/* Indication */
> +		if (g_slist_find_custom(channel->indicate,
> +				GUINT_TO_POINTER(handle), handle_cmp) != NULL) {
> +			if (channel->outstanding_indication)
> +				attrib_sched_indication(channel, attr);
> +			else
> +				attrib_indicate_client(channel, attr);
> +		}
> 	}
> }
> 
> @@ -1111,6 +1179,7 @@ void attrib_server_exit(void)
> 
> 		g_slist_free(channel->notify);
> 		g_slist_free(channel->indicate);
> +		g_slist_free(channel->pending_indications);
> 		g_slist_foreach(channel->configs, (GFunc) g_free, NULL);
> 		g_slist_free(channel->configs);
> 
> -- 
> 1.7.1
> 

