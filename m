Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <79be12f70711131937v351b1a38vcb8a7d05a05249d0@mail.gmail.com>
Date: Tue, 13 Nov 2007 20:37:32 -0700
From: "John Sample" <john.m.sample@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] SCO Problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0719172464=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0719172464==
Content-Type: multipart/alternative;
	boundary="----=_Part_10176_21926953.1195011452402"

------=_Part_10176_21926953.1195011452402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm trying to create a headset device using Bluez running on an ARM system.
For some reason I still can't get dbus to start, so I can't use the hci
daemon.  So as an alternative until i get that figured out I've been trying
to pull something together using scotest and hstest from the test directory
of utils.  I can receive sco audio data just fine, but for some reason I
can't get any data to transmit.  Is there any thing special I need to do
with the audio data before I write to the sco socket?  I noticed the
following sequence number and length fields added in in scotest.c:


syslog(LOG_INFO,"Sending ...");

for (i = 6; i < so.mtu; i++)

buf[i] = 0x7f;

seq = 0;

while (1) {

*(uint32_t *) buf = htobl(seq);

*(uint16_t *) (buf + 4) = htobs(data_size);

seq++;

if (send(sk, buf, so.mtu, 0) <= 0) {

syslog(LOG_ERR, "Send failed: %s (%d)",

strerror(errno), errno);

exit(1);

}

usleep(1);

}
I tried adding those in but it didn't seem to make a difference.  Am I
missing something else?  Thanks in advance if you can help, this really has
me stumped.

-- 
John Sample

------=_Part_10176_21926953.1195011452402
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I&#39;m trying to create a headset device using Bluez running on an ARM system.&nbsp; For some reason I still can&#39;t get dbus to start, so I can&#39;t use the hci daemon.&nbsp; So as an alternative until i get that figured out I&#39;ve been trying to pull something together using scotest and hstest from the test directory of utils.&nbsp; I can receive sco audio data just fine, but for some reason I can&#39;t get any data to transmit.&nbsp; Is there any thing special I need to do with the audio data before I write to the sco socket?&nbsp; I noticed the following sequence number and length fields added in in 
scotest.c:</div>
<div>&nbsp;</div>
<div><font size="2">
<p>syslog(LOG_INFO,</p></font><font color="#a31515" size="2">&quot;Sending ...&quot;</font><font size="2">);
<p></p></font><font color="#0000ff" size="2">for</font><font size="2"> (i = 6; i &lt; so.mtu; i++)
<p>buf[i] = 0x7f;</p>
<p>seq = 0;</p>
<p></p></font><font color="#0000ff" size="2">while</font><font size="2"> (1) {
<p>*(uint32_t *) buf = htobl(seq);</p>
<p>*(uint16_t *) (buf + 4) = htobs(data_size);</p>
<p>seq++;</p>
<p></p></font><font color="#0000ff" size="2">if</font><font size="2"> (send(sk, buf, so.mtu, 0) &lt;= 0) {
<p>syslog(LOG_ERR, </p></font><font color="#a31515" size="2">&quot;Send failed: %s (%d)&quot;</font><font size="2">,
<p>strerror(errno), errno);</p>
<p>exit(1);</p>
<p>}</p>
<p>usleep(1);</p>
<p>}</p></font>I tried adding those&nbsp;in but it didn&#39;t seem to make a difference.&nbsp; Am I missing something else?&nbsp; Thanks in advance if you can help, this really has me stumped.&nbsp; <br clear="all"><br>-- <br>John Sample </div>

------=_Part_10176_21926953.1195011452402--


--===============0719172464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0719172464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0719172464==--
