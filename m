Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <434E8EA3.4070101@imap.cc>
From: Alex Viskovatoff <viskovatoff@imap.cc>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized
References: <434C6E2E.9070105@imap.cc>	 <1129097566.4922.1.camel@localhost.localdomain>  <434D4765.603@imap.cc> <1129195847.6543.1.camel@localhost.localdomain>
In-Reply-To: <1129195847.6543.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 13 Oct 2005 12:43:15 -0400

Hi Marcel,

> 
> try the attached patch. Hopefully they haven't changed the protocol.
> 

Thanks for the patch. Now hid2hci produces

   Switching device 046d:c50c to HCI mode was successful

Unfortunately however, "hciconfig -a" still produces a blank line. Also, 
I can type "hid2hci" any number of times, and it always produces the 
same response, which makes me think it isn't doing much of anything. 
Furthermore, if I give the command "hid2hci" when hcid and sdpd are 
stopped, I can continue to use the diNovo keyboard and mouse 
undisturbed, which suggests that the receiver never really leaves hid mode.

I don't know if they've changed the protocol, or if it's simply that 
other patches along the lines of this one are required.

Regards,

Alex


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
