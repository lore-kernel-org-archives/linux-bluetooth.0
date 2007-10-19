Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710191635v1c9c6c84pcd6b82d0affcefab@mail.gmail.com>
Date: Fri, 19 Oct 2007 17:35:04 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4718E8E0.5050608@silicom.fr>
MIME-Version: 1.0
References: <4718E8E0.5050608@silicom.fr>
Subject: Re: [Bluez-devel] [PATCH] newapi patch v1
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

Fabien

> All, here is the first version of the patch that moves to the newapi
> usage... yeheee !!

This is all stuff we definitely need. Johan and Luiz have been working
more closely with this so I will leave it up to them to
comment/commit.

> As nobody suggested a new name, i've just chose one, which is
> "btaudioservice.h" :-). Of course this can be changed if somebody
> prefers a better name :-)

maybe audioclient.h. something like that would mesh best if it was
ever made officially externally available (ie
/usr/include/bluetooth/audioclient.h)

brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
