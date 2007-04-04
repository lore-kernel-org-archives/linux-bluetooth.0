Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0704041456y2dca00b2y3bbd3f298903fe8d@mail.gmail.com>
Date: Wed, 4 Apr 2007 18:56:55 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ddea76ce0704041157l3b20177ew6c6a259509171cfc@mail.gmail.com>
MIME-Version: 1.0
References: <ddea76ce0704041157l3b20177ew6c6a259509171cfc@mail.gmail.com>
Subject: Re: [Bluez-devel] l2cap sockets, sdp
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Meenakshi,

Check the utils/tools/sdptool.c code.
If you want search handles/service records use the following functions:

sdp_service_search_req
sdp_service_attr_req
sdp_service_search_attr_req

sdp_service_search_async
sdp_service_attr_async
sdp_service_search_attr_async

BR,
Claudio.
-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

On 4/4/07, Meenakshi Seeballack <meena2010@gmail.com> wrote:
> hello, I did not think I needed to use D-Bus with SDP and L2CAP.
> Would someone please provide me more information on how the SDP sends data
> with L2CAP as the transport layer?
> Or point me to a direction where I can find the information?
> Thanks in advance
> Meena

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
