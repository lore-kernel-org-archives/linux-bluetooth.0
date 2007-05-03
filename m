Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 3 May 2007 10:53:55 +0530
Message-ID: <001601c78d43$3f03d710$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <1178169412.6891.36.camel@violet>
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

Hi Marcel,

On Thursday, May 03, 2007 10:47 AM +0530, Marcel Holtmann wrote:
>>> How about the 2-EV* and 3-EV* packet types? The spec says that a 0
>>> for these bits means they have been enabled. Shouldn't you also
>>> check for their support in the feature mask?
>> 
>> Good question.  I'm not entirely sure of this, however I did not
>> interpret the specification in this manner.  All it says is that
>> there is a specific feature mask to disable 2-EV and 3-EV packets. 
>> There is nothing to say whether or not they are explicitly enabled. 
>> Also the examples in the specification use the esco feature masks in
>> the same manner as I do.  So I would assume that if EV3 support is
>> not enabled, then 2-EV3 and 3-EV3 packets will not be used by the
>> controller as well.  However, I could be wrong. 
> 
> don't worry about packet types. This is the link managers job. Enable
> as much packet types as possible.

But you'll fall into trouble if the local controller does not support
the packet type that you've enabled.
In Denis' case it worked because the device supported the 2-EV* and
3-EV* packet types and he "accidentaly" enabled them.
Why not check their support in the feature mask as well?

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
