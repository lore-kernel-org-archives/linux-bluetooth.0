Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Qualification Testing
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Daryl Van Vorst <daryl@wideray.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001101c315ac$7f545fa0$5796fea9@baked>
References: <001101c315ac$7f545fa0$5796fea9@baked>
Content-Type: text/plain
Message-Id: <1052439014.1069.9.camel@pegasus.local>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 09 May 2003 02:10:07 +0200

Hi Daryl,

> Have a look at the rfcomm_recv_rpn() function pasted below. I did a diff
> between it and the latest, and the only difference is how a variable is
> declared - nothing significant.
> 
> Here's what I see happening:
> 
> Take a look at XON and XOFF. If we see a value we don't like, we set
> rpn->xon_char to the value that we would like to see. We also update the
> rpn_mask variable. Then at the bottom of the function we call
> rfcomm_send_rpn() with xon_char and not rpn->xon_char. So it sends 0 instead
> of the desired character, but it does send the correct rpn_mask.
> 
> It looks to me like most of the tests act on the right variables. Just xon,
> xoff, and flow control appear to have the problem. 
> 
> Do you agree?

it seems that you are right. I have a fix for this in my repository.

Regards

Marcel




-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
