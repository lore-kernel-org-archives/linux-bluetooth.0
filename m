Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 30 May 2006 12:02:17 +0200
From: =?windows-1252?Q?G=F6tz_Issel?= <g.issel@fh-wolfenbuettel.de>
To: bluez-devel@lists.sourceforge.net
Message-id: <13960213768f.13768f139602@fh-wolfenbuettel.de>
MIME-version: 1.0
Subject: [Bluez-devel] SDP without results
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

Hi, 

I am trying to discover services of a device, looking for the SAP
service. In my understanding this is the hex ID for uuid  0x112d .

I have been trying to use the sample of Albert Huang
(http://people.csail.mit.edu/albert/bluez-intro/)   section 4.4 .

The service id is defined as
    uint32_t svc_uuid_int[] = { 0x0, 0x0, 0x0, 0x112d };

The line
    session = sdp_connect( BDADDR_ANY, &target, SDP_RETRY_IF_BUSY );

results in (checked via printf)
	session->state=0, 
	session->flags=1, 
	session->sock=3, 
	session->local=0,
	session->tid=0

The line 
err = sdp_service_search_attr_req( session, search_list, \
            SDP_ATTR_REQ_RANGE, attrid_list, &response_list);

gives err = 0 , so all is fine up to there.

The following FOR-loop is never entered ( for (; r; r = r->next ) {....  ) !

Any ideas ? 
My source code under : http://www.goetzi.de/try1.html

Using the command line tool "sdptool search 0x112d" gives perfect
results by the way.

Goetz


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
