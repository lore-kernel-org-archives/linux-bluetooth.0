Return-Path: <cyrus@holtmann.org>
Date: Thu, 14 Jan 2010 16:41:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Zotov <whitequark@whitequark.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Handset voice dial signalling patch
Message-ID: <20100114144123.GA31691@jh-x301>
References: <4B4D780F.1080405@whitequark.ru>
 <20100113083247.GA18980@jh-x301>
 <4B4D8C5A.8070006@whitequark.ru>
 <20100113092620.GA20024@jh-x301>
 <4B4E3A98.8000605@whitequark.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4B4E3A98.8000605@whitequark.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 14, 2010, Peter Zotov wrote:
> Johan Hedberg wrote:
> >>+	gboolean voice_dial;
> >>+	gboolean voice_dial_req;
> >
> >I'm not so sure that it'll be useful to have this state info in
> >headset.c. I suspect for the most part voice recognition will be a
> >platform specific issue that can be taken care of by the telephony
> >driver. So I'd leave out these new variables for now and add them later
> >if it turns out that there's actually some use for them in headset.c.
> >
> >After this change I think the patch could be pushed upstream.
> Fixed.

Thanks, however there are still a couple of things that I noticed (sorry
for not spotting them earlier). Once the issues in the code are fixed,
please create a patch that's appliable using git am, i.e. commit to your
own tree (with an appropriate commit message) and prepare a patch file
with git format-patch.

> +static int voice_dial(struct audio_device *device, const char *buf)
> +{
> +	if (strlen(buf) < 9)
> +		return -EINVAL;
> +
> +	gboolean start_dialing;

No variable declarations after code in the same scope. Please check your
patch with the configure script options used by bootstrap-configure and
you'll get something like the following with your patch:

audio/headset.c: In function ‘voice_dial’:
audio/headset.c:1145: error: ISO C90 forbids mixed declarations and code

> +void telephony_voice_dial_req(void *telephony_device, gboolean enable)
> +{
> +	debug("telephony-dummy: got %s voice dial request",
> +			enable ? "enable" : "disable");
> +
> +	g_dbus_emit_signal(connection, "/org/bluez/test",
> +			"org.bluez.TelephonyTest", "VoiceDial",
> +			DBUS_TYPE_INVALID);
> +
> +	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
> +}

Why return ERROR_NOT_SUPPORTED instead of ERROR_NONE here? After all,
you did successfully process the command (i.e. send the signal).

Johan
