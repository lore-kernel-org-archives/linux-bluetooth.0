Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Dealing with the bluez-utils dependencies
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05051014407d4d3b0a@mail.gmail.com>
References: <1115722824.8949.242.camel@pegasus>
	 <4280D256.1000804@xmission.com> <1115739962.12058.19.camel@pegasus>
	 <e1effdeb05051014407d4d3b0a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1115830756.23458.63.camel@pegasus>
Mime-Version: 1.0
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
Date: Wed, 11 May 2005 18:59:16 +0200

Hi Claudio,

> Regarding D-Bus support for pand and hcid.
> DBUS is under development and there is backward compatibility problem.
> Some APIs changed, I suggest check the dbus version at build time
> and fix the code to support this. The latest version(0.33) is not compatible
> with 0.23.

I am not the D-Bus expert here. So send me patches. However I am fine
with only supporting the latest version, because it is still an optional
feature.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
