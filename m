Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40AB4D9F.7010307@telus.net>
From: Ken <a5a33956@telus.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] rfcomm confusion
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 19 May 2004 05:05:51 -0700

I am trying to create a bluetooth serial connection between my linux 
laptop and iPAQ pda.
I'm using the command "rfcomm connect hci0 00:11:22:33 1" and it appears 
to work.
the connection shows up on the iPAQ and when I go to the status it 
displays 0 bytes transfered - 0 bytes received.

so, now i'm trying to send some data over this connection. my 
expectation was that i could do something like:
echo "test" > /dev/rfcomm0
and then see 4 bytes received on the iPAQ interface, however the byte 
counts on the ipaq remain 0.

does it make sense to try and send data this way? if not, can anybody 
suggest how i should be trying to send data over an rfcomm connection?

thanks!
ken




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
