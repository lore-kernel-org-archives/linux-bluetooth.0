Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W17E4F36814D533D4CCFA00C06E0@phx.gbl>
From: "" <semiyd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Wed, 5 Dec 2007 06:43:51 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Does bluez support SCO audio over PCM as well as HCI?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1094627787=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1094627787==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi All:


         The current bluez supports sco audio channel over hci to do HSP,HFP.
         But I have a ST2500c bluetooth chip and it only supports SCO over PCM.  That means, i'll have to connect my CPU(ARM9)'s PCM interface to the ST2500C bluetooth chip's PCM interface .And the audio data is transfered by PCM not HCI after sco channel is established(correct me if im wrong) .  
          Does bluez support such a function?
  If it doesn't , maybe i should do some coding like :  establishing sco connection..... transfer data through PCM interface....etc.   Is that right?




Thanks




semiyd





_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx


--===============1094627787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============1094627787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1094627787==--
