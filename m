Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] can not support multiple "Class of Device"?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <OFF94009FD.979DC289-ON48257004.002A9237-48257004.002AFF0D@zte.com.cn>
References: 
	 <OFF94009FD.979DC289-ON48257004.002A9237-48257004.002AFF0D@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1116328601.10063.32.camel@pegasus>
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
Date: Tue, 17 May 2005 13:16:41 +0200

Hi,

> in the file "hcid.conf" we can set the value of "Class of
> Device".there is a question: if I want to run several profiles
> simultaneously, such as pand =E3=80=81dund=E3=80=81future ctpd, how can=
 I set the
> value of "Class of Device"? is it necessary to modify the hcid's code
> to figure out the question?=20

it is not possible to support multiple class of device values. If you
are running multiple profiles you need to find one that matches best to
your case. Check the specification of your profiles for more details.
Some of them talk about it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
