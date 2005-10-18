Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20051018122257.47829.qmail@web34115.mail.mud.yahoo.com>
From: Joe Samuel <sjoe2@yahoo.com>
Subject: Re: [Bluez-devel] SBC Decoder Performance
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 18 Oct 2005 13:22:57 +0100 (BST)

Brad,
> the decoder is still doing everything in floating
>point
Yup. I just came to notice that. 
Thank you for the confirmation.

Joe


On 10/18/05, Brad Midgley <bmidgley@xmission.com>
wrote:

    Joe

    yes... the decoder is still doing everything in
floating point. it will
    be much faster in 64 and eventually 32 bit fixed
point. i've been
    optimizing it but didn't hit that yet.

    brad

    > Hi,
    > While experimenting with the SBC codec, I
observed
    > that the decoder tends to be sluggish as
compared with
    > the encoder (about 20 times). Has anyone noticed
this?
    > Is this behavior expected or did I make some
mistake
    > in my analysis?
    >
    > Joe
    >
    >
    >
    >
___________________________________________________________
    > How much free photo storage do you get? Store
your holiday
    > snaps for FREE with Yahoo! Photos
http://uk.photos.yahoo.com
    >
    >
    >
-------------------------------------------------------
    > This SF.Net email is sponsored by:
    > Power Architecture Resource Center: Free
content, downloads, discussions,
    > and more.
http://solutions.newsforge.com/ibmarch.tmpl
    > _______________________________________________
    > Bluez-devel mailing list
    > Bluez-devel@lists.sourceforge.net
    >
https://lists.sourceforge.net/lists/listinfo/bluez-devel



   
-------------------------------------------------------
    This SF.Net email is sponsored by:
    Power Architecture Resource Center: Free content,
downloads, discussions,
    and more.
http://solutions.newsforge.com/ibmarch.tmpl
    _______________________________________________
    Bluez-devel mailing list
    Bluez-devel@lists.sourceforge.net
   
https://lists.sourceforge.net/lists/listinfo/bluez-devel



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
