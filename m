Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Daniela Taubert <daniela.taubert@physik.uni-muenchen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] trying to connect to a M2500 Plantronics headset
References: <200505301752.38707.daniela.taubert@physik.uni-muenchen.de> <200505301929.23992.daniela.taubert@physik.uni-muenchen.de> <429CA856.6020602@xmission.com>
In-Reply-To: <429CA856.6020602@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505312328.47057.daniela.taubert@physik.uni-muenchen.de>
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
Date: Tue, 31 May 2005 23:28:46 +0200

> Just to let you know, it looks like a question for an expert with your
> distro (suse?) to see how the pin query is working when pairing and what
> might be going wrong.

Well, I finally got the pin thingy to work - there was a line with the wrong 
pin-helper program in /etc/bluetooth/hcid.conf 

(sorry, that was really stupid!)

So now I get a connection, but btsco still doesn't work. I don't get any error 
messages, it just doesn't do anything...

strace gives me the following, which I don't really understand:

> strace btsco <btaddr> 2

(...)
poll([{fd=4, events=POLLIN}, {fd=3, events=POLLIN|POLLOUT|POLLERR|POLLNVAL}], 
2, -1) = -1 EINTR (Interrupted system call)
--- SIGWINCH (Window changed) @ 0 (0) ---
poll(

Doesn't sound nice... from what I found on the net btsco should create output, 
but here it doesn't...

Daniela


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
