Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: paivakil@gmail.com (Mahesh T. Pai)
Date: Thu, 08 Feb 2007 09:40:02 +0530
Message-ID: <87k5ytqoh1.fsf@nandini.home>
References: <45CA05A6.5000808@gmail.com>
	<20070207102742.gs40wgg8coc4048w@www.webmail4.com>
	<45CA1BE6.5040907@pracucci.com> <45CA257C.9020904@gmail.com>
	<5b9417770702071127t4dcc7835h2e860b7992e2bb0c@mail.gmail.com>
	<45CA29F7.6070607@gmail.com>
	<5b9417770702071206t733f7c64s966c9249f7eadf28@mail.gmail.com>
	<45CA47A8.5000109@gmail.com>
	<5b9417770702071950g51f03979m21e636a53f4c0900@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Is this list dead? Here is my problem...
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

"John H." <mistamaila@gmail.com> writes:

> Something like this
>
>
> rfcomm connect 0 00:1A:77:ED:D1:97 4
>
> That makes rfcomm0 on channel 4.

Is there some means of giving remote mac ids an alias? Something like
editing some configuration file in the remote machine / device telling
it to identify itself as `rmachine' and then saying

rfcomm connect rmachine [options]' on the local machine?

-- 
 Mahesh T. Pai <<>> http://paivakil.blogspot.com/
TRUTH,  n.   An   ingenious  compound  of  desirability  and
  appearance.   Discovery of  truth is  the sole  purpose of
  philosophy, which  is the  most ancient occupation  of the
  human  mind  and has  a  fair  prospect  of existing  with
  increasing activity to the end of time.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
