Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20609190330u7f785d88x1e054cf9b027807e@mail.gmail.com>
Date: Tue, 19 Sep 2006 18:30:04 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Can I search two service at the same time?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1558560504=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1558560504==
Content-Type: multipart/alternative;
	boundary="----=_Part_285256_9250753.1158661804854"

------=_Part_285256_9250753.1158661804854
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Problem,
   I have seen that there is a function named sdp_service_search_req,
   So,I append two service uuid such as obexpush's uuid and another
service's uuid into the search list, I want to get the two services' info
only call search func once.
  and then set the max_rec_num = 2,
  then call
       sdp_service_search_req(session,search_list,2,&rsp_list);
 but ,I have seen that the func return 0, but the rsp_list is NULL.

 Who can you tell me why?
thank you.

-- 
With respects,
   Mingfan.Lu

------=_Part_285256_9250753.1158661804854
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><br clear="all">Problem,</div>
<div>&nbsp;&nbsp; I have seen that there is a&nbsp;function named sdp_service_search_req,</div>
<div>&nbsp;&nbsp; So,I append two service uuid such as obexpush's uuid and another service's uuid into the search list, I want to get the two services' info only call search func once.</div>
<div>&nbsp; and then set the max_rec_num = 2,</div>
<div>&nbsp; then call </div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdp_service_search_req(session,search_list,2,&amp;rsp_list);</div>
<div>&nbsp;but ,I have seen that the func return 0, but the rsp_list is NULL.</div>
<div>&nbsp;</div>
<div>&nbsp;Who can you tell me why?</div>
<div>thank you.</div>
<div><br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu </div>

------=_Part_285256_9250753.1158661804854--


--===============1558560504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1558560504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1558560504==--
