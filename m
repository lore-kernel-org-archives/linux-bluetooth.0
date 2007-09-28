Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <f8e53fb0709280211o1e447c88mfcad13e26f1c8343@mail.gmail.com>
References: <f8e53fb0709280019i51e9175bl5a3fa8fa8965c75d@mail.gmail.com>
	<1190964593.6484.83.camel@aeonflux.holtmann.net>
	<f8e53fb0709280211o1e447c88mfcad13e26f1c8343@mail.gmail.com>
Date: Fri, 28 Sep 2007 23:50:57 +0200
Message-Id: <1191016257.6484.87.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Detecting disconnection when using RFCOMM tty API
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Andrea,

> > if you poll the TTY you should get a HUP signal. Keeping the same file
> > descriptor is not possible since on disconnect the TTY will be close. It
> > won't re-connect automatically. So you have to open it again to trigger
> > the actual re-connection.
> 
> I'm trying to catch the HUP but with no luck. I'm probably doing
> something wrong. Basically I do the following:

not the HUP signal from the process. The HUP signal when using poll().

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
