Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 May 2009 09:49:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Forrest Zhao <forrest.zhao@intel.com>
Cc: linux-bluetooth@vger.kernel.org, forrest.zhao@gmail.com
Subject: Re: [PATCH] add support for HFP plugin for oFono(ofono.org)
Message-ID: <20090513064940.GA22585@jh-x301>
References: <1242183319-24470-1-git-send-email-forrest.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1242183319-24470-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

In general the patch looks ok'ish (which it should since it seems to be
largely based on the maemo driver), though I do have a couple of comments:

On Wed, May 13, 2009, Forrest Zhao wrote:
> +static int send_method_call(const char *dest, const char *path,
> +                                const char *interface, const char *method,
> +                                DBusPendingCallNotifyFunction cb,
> +                                void *user_data, int type, ...);

I don't think there should be any need for this forward declaration. Just
move the function higher up in the file.

> +static void answer_reply(DBusPendingCall *call, void *user_data)
> +{
> +	DBusMessage *reply;
> +	DBusError err;
> +
> +	reply = dbus_pending_call_steal_reply(call);
> +	dbus_error_init(&err);
> +	if (dbus_set_error_from_message(&err, reply)) {
> +		error("oFono answer incoming call failed: %s, %s",
> +			err.name, err.message);
> +		dbus_error_free(&err);
> +		goto done;
> +	}
> +
> +done:
> +	dbus_message_unref(reply);
> +}
> +
> +void telephony_answer_call_req(void *telephony_device)
> +{
> +	struct voice_call *vc = find_vc_with_status(CALL_STATUS_INCOMING);
> +	int ret;
> +
> +	if (!vc) {
> +		telephony_answer_call_rsp(telephony_device,
> +					CME_ERROR_NOT_ALLOWED);
> +		return;
> +	}
> +
> +	ret = send_method_call(OFONO_BUS_NAME, vc->obj_path,
> +			OFONO_VC_INTERFACE,
> +			"Answer", answer_reply,
> +			NULL, DBUS_TYPE_INVALID);
> +
> +	if (ret < 0) {
> +		telephony_answer_call_rsp(telephony_device,
> +					CME_ERROR_AG_FAILURE);
> +		return;
> +	}
> +
> +	telephony_answer_call_rsp(telephony_device, CME_ERROR_NONE);
> +}

If you're actually going to handle the D-Bus reply to the Answer method
call (which the maemo driver doesn't do -- it relies on the state signals
instead), doesn't it make sense to call telephony_answer_call_rsp in the
reply handler (answer_reply) instead of here?

Johan
