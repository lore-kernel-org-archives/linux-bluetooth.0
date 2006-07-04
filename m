Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44AADFBA.1030901@runbox.com>
Date: Tue, 04 Jul 2006 22:38:02 +0100
From: Tom K <tomk@runbox.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44A9923A.4050200@runbox.com>
	<e1effdeb0607040642j3c3e0a34l67565401acb2f318@mail.gmail.com>
In-Reply-To: <e1effdeb0607040642j3c3e0a34l67565401acb2f318@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------040801010103010906070001"
Subject: Re: [Bluez-devel] hcid fails to start after upgrade
 to	bluez-libs/bluez-utils 3.1 (Continued)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040801010103010906070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Claudio Takahasi wrote:
> Hi Tom,
>
> I was not able to reproduce the problem that you described. I found
> some problems with dongles that doesn't support set the inquiry mode,
> but I never noticed "Connection timed out".
> Could you send the hcidump?
>
> BR,
> Claudio.
>   

Here's the dump file, Claudio. I started hcidump immediately after 
plugging in the dongle, and then started the bluetooth daemons. I got 
the same sequence of USB and hcid log messages as before, and let it 
cycle through 6 consecutive USB addresses before shutting it down. To my 
inexpert eye, there doesn't seem to be much in the dump, but hopefully 
it will mean something to you.

TIA
Tom.

--------------040801010103010906070001
Content-Type: application/octet-stream;
 name="bt20060704.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bt20060704.dump"

BAAAAFvcqkS+iw0AAQMQAAcAAQBb3KpEv5INAAQPBAABAAAEAAAAW9yqRPGSDQABBRAADwAB
AFvcqkRIpg0ABA4MAQMQAP//BQAAAAAABAAAAFvcqkR4pg0AAQkQAA4AAQBb3KpEackNAAQO
CwEFEACAAEAIAAgABAAAAFvcqkSbyQ0AASUMAA0AAQBb3KpEQdENAAQOCgEJEADjEq12BAAG
AAAAW9yqRILRDQABBQwCAK0JAAEAW9yqRLPkDQAEDgYBJQwAYAAGAAAAW9yqRM3kDQABGAwC
AIAHAAEAW9yqRH/sDQAEDgQBBQwABgAAAFvcqkSQ7A0AARYMAgB9BwABAFvcqkQVAA4ABA4E
ARgMAAQAAABb3KpEJgAOAAEBEAAHAAEAW9yqRNkHDgAEDgQBFgwADwABAFvcqkSAFw4ABA4M
AQEQAABhAAEKAGEABAAAAFvcqkRXTQ4AAQMQAA8AAQBb3KpErGEOAAQODAEDEAD//wUAAAAA
AAUAAABb3KpEE2IOAAFFDAEABAAAAFzcqkSYugAAAQMMAA==
--------------040801010103010906070001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------040801010103010906070001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040801010103010906070001--
