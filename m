Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Aug 2012 15:30:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0] gdbus: Fix compilation error if macro "error"
 is defined
Message-ID: <20120816123023.GA24627@x220>
References: <1343816803-16228-1-git-send-email-jaganath.k@samsung.com>
 <20120816074909.GA29336@x220>
 <69D93B07FE0348AC8E5E38C3EF8D6DB7@sisodomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <69D93B07FE0348AC8E5E38C3EF8D6DB7@sisodomain.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Thu, Aug 16, 2012, Jaganath Kanakkassery wrote:
> >On Wed, Aug 01, 2012, Jaganath Kanakkassery wrote:
> >>The variable "signature" used in error is not defined.
> >>---
> >>v0 -> Made error message as per Lucas's suggestion
> >>
> >> gdbus/object.c |    4 ++--
> >> 1 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/gdbus/object.c b/gdbus/object.c
> >>index 900e7ab..9689006 100644
> >>--- a/gdbus/object.c
> >>+++ b/gdbus/object.c
> >>@@ -645,8 +645,8 @@ static dbus_bool_t
> >>emit_signal_valist(DBusConnection *conn,
> >> goto fail;
> >>
> >> if (g_dbus_args_have_signature(args, signal) == FALSE) {
> >>- error("%s.%s: expected signature'%s' but got '%s'",
> >>- interface, name, args, signature);
> >>+ error("%s.%s: got unexpected signature '%s'", interface, name,
> >>+ dbus_message_get_signature(signal));
> >> ret = FALSE;
> >> goto fail;
> >> }
> >
> >What's the reason for dropping printing of the value of "args"? I'd
> >think that's quite useful in figuring out what went wrong. Even if there
> >is a reason to drop it it has nothing to do with fixing the compilation
> >error due to undefined "signature" and should therefore be in its own
> >patch.
> >
> 
> "args" is a structure now and that's the reason it is removed and I think
> the complete signature of args cannot be available at the point
> where it is printed.
> How about changing the commit message to "Correct error message"?

No, keep the summary line as is, but please add a note about this args
variable to the rest of the message, i.e. something like "The variable
"signature" is not defined and "args" is now a struct instead of a
string".

Johan
