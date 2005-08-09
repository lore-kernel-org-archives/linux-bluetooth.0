Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bccmd patch, find connection handle by bdaddr
References: <20050808115620.EEB243BF@arbetsmyra.dyndns.org> <1123522342.7751.49.camel@pegasus>
In-Reply-To: <1123522342.7751.49.camel@pegasus>
MIME-Version: 1.0
Message-Id: <20050809144239.29D538AD@arbetsmyra.dyndns.org>
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
Date: Tue, 9 Aug 2005 16:36:11 +0200


> > them small and separate. The one attached makes bccmd able to find
> > a ACL connection handle itself, instead of require user to provide
> > it on commandline. I'm using it in a cmd_keylen() patch (which I
> > post when this one gets applied).


> please follow our coding style. This little code snippet breaks it 

Hi
I'm refreshing myself on "Documentation/CodingStyle" now and will make 
some adjustments.


> and it includes a free(NULL) bug.

That's actually ok. According to both K&R and the GNU manuals it is 
fully legal. The C-lib checks for NULL and in that case does nothing. I 
can add an extra check though if you want the double safetey. B.T.W I 
saw your most resent commit on  libs/src/bluetooth.c  contains a 
bt_malloc(). Is that to be used instead from now on?


> The handle is uint32_t 

Really? Strange. The kernel #includes define the handle as an uint16_t 
only (struct hci_conn). And according to the v2.0 spec only the least 
12-bits is actually used. I then used a signed 32 to be able to do a 
return of both those unsigned 12/16 bits and a -1 error indicator. 
Perhaps I've missed something, where does the remaining data come from?


> and you should keep the endian conversion in mind.

The handle returned from ioctl() is in host byte order already since 
the kernel makes a conversion. What to do next with it one can discuss. 
Especially when it comes to be used with "complex" lengthed Varid's 
it's easy to make mistakes due to quite odd BCCMD protocol byte 
ordering (where 32-bits are neither of big/little-endian). I was 
thinking it's probably easiest to leave the handle as-is for all of 
those many:
	buf[0] = handle & 0xff;
	buf[1] = handle >> 8;
which complex BCCMD require. I'm open to suggestions though.


Regards
/Ronny





-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
