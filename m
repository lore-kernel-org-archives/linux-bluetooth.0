Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Link interrupted/destroyed by CC on other hci
	device
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Gaufer <andreas.gaufer@blue-cell-networks.com>
Cc: Bluez Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040628215642.516c0ff6.Andreas.Gaufer@blue-cell-networks.com>
References: <20040628215642.516c0ff6.Andreas.Gaufer@blue-cell-networks.com>
Content-Type: text/plain
Message-Id: <1088453745.6030.89.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Jun 2004 22:15:45 +0200

Hi Andreas,

> I noticed that running OBEX Transfers on one hci device are interrupted
> (L2CAP link is destroyed) by a CC that is issued on a different hci dev.
> 
> 
> As far as i can see it only happens on T6xx Phones from SE but this is
> not for sure now. Im will start digging on this phenomina now. 
> 
> I would greatly appreciate hints or thoughts why this could happen. 

I don't think that this can happen, but who knows for sure. Make binary
dump files and compare the timestamps of the two HCI devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
