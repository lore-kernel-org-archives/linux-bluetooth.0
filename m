Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <b150d3010709030446n2788151fva030f8b868a68404@mail.gmail.com>
Date: Mon, 3 Sep 2007 17:16:44 +0530
From: "Shankar Ramesh" <hrshankar@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] bluez-utils transfer service
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2102346748=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============2102346748==
Content-Type: multipart/alternative;
	boundary="----=_Part_10280_7579619.1188820004873"

------=_Part_10280_7579619.1188820004873
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am using bluez-utils 3.18.  I am trying to use transfer service provided
by bluez-utils.
When i try to activate the service using

activateservice("transfer");  ----> api present in org.bluez.Managerinterface

i get the following error

Error: Exec format error


Neither can i start the service using the start() api present in
org.bluez.service interface... For this i use the path returned by the
listservices()
api.
path: /org/bluez/service_transfer

Can anyone please tell me how to activate this service and use it for obex
transfers...

Thanks
Shankar

------=_Part_10280_7579619.1188820004873
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am using bluez-utils 3.18.&nbsp; I am trying to use transfer service provided by bluez-utils.<br>When i try to activate the service using <br><br><span style="font-weight: bold;">activateservice(&quot;transfer&quot;);
</span>&nbsp; ----&gt; api present in <span style="font-weight: bold;">org.bluez.Manager interface</span><br><br>i get the following error<br><br><span style="font-weight: bold;">Error: Exec format error</span><br><br><br>Neither can i start the service using the 
<span style="font-weight: bold;">start() </span>api present in <span style="font-weight: bold;">org.bluez.service </span>interface... For this i use the path returned by the <span style="font-weight: bold;">listservices() 
</span>api.&nbsp; <br><span style="font-weight: bold;">path</span>:<span style="font-style: italic;"><span style="font-style: italic;"> </span>/org/bluez/service_transfer</span><br style="font-weight: bold;"><br>Can anyone please tell me how to activate this service and use it for obex transfers...
<br><br>Thanks<br>Shankar<br>

------=_Part_10280_7579619.1188820004873--


--===============2102346748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============2102346748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2102346748==--
