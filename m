Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Date: Thu, 23 Oct 2003 08:03:46 +0200
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] RFCOMM TTY data loss
In-reply-to: <Pine.GSO.4.20.0310221044310.1278-100000@angel.urbana.css.mot.com>
Sender: bluez-devel-admin@lists.sourceforge.net
To: Aaron Klish <aklish1@urbana.css.mot.com>
Cc: Aaron Klish <aklish1@wombat.urbana.css.mot.com>,
   Aaron Klish <AKLISH1@motorola.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Errors-To: bluez-devel-admin@lists.sourceforge.net
Message-id: <1066889032.18996.28.camel@pegasus>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
References: <Pine.GSO.4.20.0310221044310.1278-100000@angel.urbana.css.mot.com>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Id: <bluez-devel.lists.sourceforge.net>

Hi Aaron,

>   Are there any plans in the future to allow control of RFCOMM MTU and credits from user space?
> I'm using 2.4.20 (mh9 patch) and these parameters are currently assigned default values in the kernel.
> L2CAP already has an option to control MTU through setsockopt.  It seems like adding control
> for parameters for RFCOMM would be a good feature - perhaps also through setsockopt?   Any thoughts
> on this?  Thanks.

the Linux implementation of RFCOMM is a stream and so it don't have a
MTU. You have the in and out MTU of the underlaying L2CAP PSM 3 and we
try to set them to 1024 by default. We have talked about this some time
ago (look at the archive) and there is no proof that having a different
L2CAP MTU improves the performance of RFCOMM.

The credits are not for the user space, because they are only used for
the flow control. These kind of stuff must be handled by the RFCOMM
layer and nobody should have to worry about it. If there is a problem
with it, we have to fix it in the RFCOMM layer itself.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
