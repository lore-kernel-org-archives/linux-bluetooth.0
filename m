Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300804281346y5b8d41bav944ae3d32aba376@mail.gmail.com>
Date: Mon, 28 Apr 2008 14:46:09 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1209405939.17679.157.camel@violet.holtmann.net>
MIME-Version: 1.0
References: <d89ddf300804261337y599d34d5p4454238c08cb9698@mail.gmail.com>
	<1209405939.17679.157.camel@violet.holtmann.net>
Subject: Re: [Bluez-devel] exports for pulseaudio
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Marcel

>  have ipc.[ch] and these files have LGPL license so they can be copied
>  out of the side bluez-utils source code and used by other libraries or
>  systems. Nothing has changed here. It is the job of the external plugin
>  developers to keep this in sync with bluez-utils. No API guarantee.

ok

>  For SBC the same thing applies at the moment.

fortunately the codec is self-contained so api breakage won't occur.
Quality or speed improvements might need to get synchronized from time
to time.

There is one fix in the quality of the internal sbc codec that I
should push into the old libsbc, assuming we don't just kill off the
standalone libsbc altogether.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
