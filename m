Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060308164641.23944.qmail@web31111.mail.mud.yahoo.com>
From: Yu Zhi <kuanyz@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-285758948-1141836401=:23868"
Subject: [Bluez-users] Fwd: DHCP for dund
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
Date: Wed, 8 Mar 2006 08:46:41 -0800 (PST)

--0-285758948-1141836401=:23868
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 I'd using dund to establush connectino with my Pocket PC. Here's the steps I'd taken:
  
  1) I'd typed the following command in a terminal:
  echo 1 > /proc/sys/net/ipv4/ip_forward
  hcid
  sdpd
  
  2) Put the following lines in a file called /etc/ppp/peers/dun
  115200       
  192.168.1.18:10.0.1.40        
  local
  ms-dns 192.168.1.1        
  noauth        
  debug  
  
  3) run in terminal
  dund --nodetach --listen --persist --msdun call dun  
  
 The steps work perfectly for my PDA to dialup to my linux server, and manage to browse the content in my webserver. However, the steps are only to assign fixed IP (in this case 10.0.1.40) to my PDA. I wish to have multiple PDA connect to the linux server, and hence fixed IP is not a solution. What should I do if i wanted DHCP server support dund for my case. Please advice.
  
  p/s I'm very fresh in Linux environment. The steps are  taken and edited  from http://howto.pilot-link.org/bluesync/ga.html. Please teach me step  by step.
  
  Regards,
  Albert       

---------------------------------

		
---------------------------------
Relax. Yahoo! Mail virus scanning helps detect nasty viruses!
		
---------------------------------
Yahoo! Mail
Bring photos to life! New PhotoMail  makes sharing a breeze. 
--0-285758948-1141836401=:23868
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

 I'd using dund to establush connectino with my Pocket PC. Here's the steps I'd taken:<br>  <br>  1) I'd typed the following command in a terminal:<br>  echo 1 &gt; /proc/sys/net/ipv4/ip_forward<br>  hcid<br>  sdpd<br>  <br>  2) Put the following lines in a file called /etc/ppp/peers/dun<br>  <font color="#000000">115200       <br>  192.168.1.18:10.0.1.40        <br>  local<br>  ms-dns 192.168.1.1        <br>  noauth        <br>  debug  <br>  <br>  3) run in terminal<br>  </font>dund --nodetach --listen --persist --msdun call dun  <br>  <br> The steps work perfectly for my PDA to dialup to my linux server, and manage to browse the content in my webserver. However, the steps are only to assign fixed IP (in this case 10.0.1.40) to my PDA. I wish to have multiple PDA connect to the linux server, and hence fixed IP is not a solution. What should I do if i wanted DHCP server support dund for my case. Please advice.<br>  <br>  p/s I'm very fresh in Linux environment. The steps are 
  taken
 and edited  from http://howto.pilot-link.org/bluesync/ga.html. Please teach me step  by step.<br>  <br>  Regards,<br>  Albert  <div>     </div><hr size="1"><p>
		<hr size=1>Relax. Yahoo! Mail 
<a href="http://us.rd.yahoo.com/mail_us/taglines/virusall/*http://communications.yahoo.com/features.php?page=221">virus scanning</a> helps detect nasty viruses!<p>
		<hr size=1>Yahoo! Mail<br>
Bring photos to life! <a href="http://pa.yahoo.com/*http://us.rd.yahoo.com/evt=39174/*http://photomail.mail.yahoo.com">New PhotoMail </a> makes sharing a breeze. 

--0-285758948-1141836401=:23868--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
