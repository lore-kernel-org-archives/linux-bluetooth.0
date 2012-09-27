Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Sep 2012 00:16:16 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH BlueZ v7 5/9] core: Queue discovery if scanning is active
Message-ID: <20120927031616.GA7630@echo>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
 <1348594686-26221-5-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1348594686-26221-5-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João, Claudio,

On 14:38 Tue 25 Sep, João Paulo Rechi Vita wrote:
> From: Claudio Takahasi <claudio.takahasi@openbossa.org>
> 
> This patch manages BR/EDR inquiry and BLE scanning discovery sessions.
> A scanning session is added in the discovery session list when there is
> a bonded device which requires re-connection.
> 
> bluetoothd decides if interleaved or scanning needs to be executed based
> on the queued discovery sessions. Interleaved discovery has higher
> priority, scanning only is executed when there is only a scanning
> session active.
> ---
>  src/adapter.c | 65 ++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 19 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 201e6a0..0a0ac8f 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -132,6 +132,7 @@ struct btd_adapter {
>  	GSList *devices;		/* Devices structure pointers */
>  	GSList *mode_sessions;		/* Request Mode sessions */
>  	GSList *disc_sessions;		/* Discovery sessions */
> +	struct session_req *scanning_session;
>  	GSList *connect_list;		/* Devices to connect when found */
>  	guint discov_id;		/* Discovery timer */
>  	gboolean discovering;		/* Discovery active */
> @@ -221,17 +222,18 @@ static struct session_req *create_session(struct btd_adapter *adapter,
>  					DBusMessage *msg, uint8_t mode,
>  					GDBusWatchFunction cb)
>  {
> -	const char *sender = dbus_message_get_sender(msg);
> +	const char *sender;
>  	struct session_req *req;
>  
>  	req = g_new0(struct session_req, 1);
>  	req->adapter = adapter;
> -	req->msg = dbus_message_ref(msg);
>  	req->mode = mode;
>  
> -	if (cb == NULL)
> +	if (cb == NULL || msg == NULL)
>  		return session_ref(req);

Sorry for taking so long to notice this, but there is a problem here.
'req->msg' is needed in 'set_mode_complete()' (around adapter.c:2329) even
when 'cb' is NULL: when setting the "Powered" or "Discoverable" property,
the session created doesn't have a 'cb' but it has a 'msg'.


[snip]


Cheers,
-- 
Vinicius
