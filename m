Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3E108FF4-C533-46A1-9119-5C87229E73A0@holtmann.org>
References: <1363655144-9705-1-git-send-email-deymo@chromium.org>
 <1364852391-15929-1-git-send-email-deymo@chromium.org> <3E108FF4-C533-46A1-9119-5C87229E73A0@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
Date: Mon, 1 Apr 2013 15:54:11 -0700
Message-ID: <CAGd9gwjWy2SFCHAQKcGhHF=La8s2UQ1PrTYM7ybXmrB2YwxQ8w@mail.gmail.com>
Subject: Re: [PATCH v2] core: Expose HIDNormallyConnectable and
 HIDReconnectInitiate properties
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, keybuk <keybuk@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Apr 1, 2013 at 2:48 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> lets split doc patches from code patches please.
ok

> Do we want to keep the terms used in the HID spec or come up with a bit more generic property names here?

I think these two properties have a very particular behavior defined
by the HID spec. Using a simpler name (like simply "connectable") will
add more noise.


> We slowly want to move over to using bool instead of gboolean. So I would prefer that any new code starts with this. And for extra points, patches that fix up the old usages are more than welcome.
ok

> Don't we have a general helper for this? We might should. Or should the input plugin store its specific values in its own file?

The %s/%s/info filename is created in 6 different places in the code.
I could add a new helper for this logic instead of having the filename
scheme spread in the code. I don't mind having a separate file for the
input plugin


> I think you need callbacks for the case when the values are not available. Otherwise the GDBus core behaves funny when attempting to get all properties.
Yes, you are right. But, in any case, I'll remove the
hid_props_present since the input interface is created passing a
sdp_record_t, so the properties will be always present. One of the
properties is mandatory (so it should be present in the SDP record)
and the other is optional and assumed as false if not present. Doesn't
make sense to move the HID spec logic to the user/client when the
properties are not present.
Even in the case of an upgrade from bluez 4 the sdp records are
correctly parsed from the old format.

Thanks for the comments!
Alex
