Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opsf3esskzeocfdv@debian>
Subject: [Bluez-users] Various questions
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
Date: Tue, 19 Oct 2004 03:08:42 +0200

Hi BlueZ List,

I'm just very confused about quite a few things.

At first, I believed ACL stands for 'Asynchronous Connection Less'
But I just read the BT_Core_v1_2 Specification that sais ACL is
Asynchronous Connection Oriented (page 118 of 1200 / Architecture page 42  
of 82)
So, what is it? I have read books and internet articles that said ACL is
connection less. Are they all wrong or am I totally messing up something?

PAN uses the bnep protocol layer. Is bnep based on rfcomm?
I think not, because I don't need to load rfcomm.o when using pand.
But looking at the figure from
http://www.rvs.uni-bielefeld.de/~heiko/bluetooth/bluetooth.pdf
(page 6) you can get this idea. (From  
http://www.holtmann.org/linux/bluetooth/)
(There are some other sources, too)

What about the three error connection modes. Is it right that they are
determined by packet type and so there is no way to turn it on / off ?
(using pand for example / which paket types does pand use?)
Because some papers speak about optionally error correction (ARQ)

Data rate:
Whats the data rate of a pand connection?
I measured a data rate of 60-65 kbyte/s one way
30-35 kbyte/s the other way.

The way I understand the Spec. (page 274 of 1200) that would be above the  
limits.
60 kbyte/s = 480 kbit/s is greater than the symmetric rate of 433 kbit/s
but 30 kbyte/s = 180 kbit/s is greater any of the asymetric data rates.

Whats my failure?

Thanks for any clarity and de-confusion.

-- 
Regards,
Christoph Torens


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
