Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Profile porting
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <f16b04cf0510032315i46206dbfnc599fc704d1d65a7@mail.gmail.com>
References: <f16b04cf0510032315i46206dbfnc599fc704d1d65a7@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1128424346.5226.13.camel@blade>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 04 Oct 2005 13:12:26 +0200

Hi Hariharan,

> Presently we are working in porting of Profile with Bluez stack.
> Anyone please advise whether the Bluez stack contains the
> 
> Serial Port Profile, Head set profile.
> 
> If yes, Advise us regarding the documents location of Profile porting

the serial port profile is supported, because we implement the RFCOMM
protocol. For the headset profile you should take a look at the ALSA
Bluetooth project.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
