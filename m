Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 3 May 2007 10:08:07 +0530
Message-ID: <001501c78d3c$dd4f3ba0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <200705031357.04459.denis.kenzior@trolltech.com>
Subject: Re: [Bluez-devel] Esco implementation patch
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

On Thursday, May 03, 2007 9:27 AM +0530, Denis KENZIOR wrote:
> Here's a modified patch that implements eSCO sockets, including
> incoming SCO connections.  This was a merge of my previous work for
> the 2.4 series of kernels, so some variables might be named
> differently than in your patch. 

How about the 2-EV* and 3-EV* packet types? The spec says that a 0 for these bits means they have been enabled.
Shouldn't you also check for their support in the feature mask?

> I've tested it on several machines here, including eSco->eSco
> connection, eSco->sco connection for both incoming and outgoing
> scenarios, everything seems fine, however I'm sure more testing is
> required. 

How did you mangage to set up an eSCO since you are using only HV* packet types (ESCO_PTYPE_MASK)?
Or is it because the 2-EV* and 3-EV* bits are "0" thus the controller thinks you want to enable those packet types?

>> this patch is incomplete. It doesn't handle incoming eSCO connections
>> and it can't handle SCO audio packets over HCI when a real eSCO
>> connection has been established.
> 
> Why do you say this? What is required in order to get eSCO packets
> flowing? 

Regards,

Mayank


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
