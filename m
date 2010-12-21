Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 0/1] Implement Compound (Multi-step) GATT Procedure
 Support
From: Brian Gix <bgix@codeaurora.org>
To: claudio.takahasi@openbossa.org, vinicius.gomes@openbossa.org
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
References: <1292626132-30029-1-git-send-email-bgix@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 21 Dec 2010 09:25:55 -0800
Message-ID: <1292952355.14993.9.camel@sealablnx02.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio & Vinicius,


On Fri, 2010-12-17 at 14:48 -0800, Brian Gix wrote:
> The following two proposed patches implement a method for correctly
> staging GATT procedures that require multiple ATT req/resp exchanges.

If you guys get a chance, could you consider this proposed change
to gattrib.[ch] and the subsequent change to gatt.c? It differs from my
initial proposed patch which subverted the gattrib queuing mechanism. It
now lets each ATT command run to completion. It also fixes the memory
leak potential that Vinicius spotted.  I think it is important that you
give it at least a cursory look, because you guys know more about bluez
GATT than anyone else here at this point.  Otherwise, I will resubmit
this version as a patch request. -- thx

> 
> The first RFC / PATCH is gattrib.[ch], which allows the caller to specify
> a gboolean indicating that the command being queued is Compound
> (even if the procedure ends up being single/atomic) and a queue ID
> number, which allows the caller to cancel the GATT procedure at any
> stage of the transaction.
> 
> IF -
> The ATT opcode being queued is specified as compound, the resulting response
> will not cause the next item in the queue to be sent until *after* the
> response has been forwarded to the caller via the response callback.
> 
> IF -
> The ATT opcode being queued is *not* compound, the resulting response
> will service the pkt queue immediately (legacy functionality).
> 
> IF -
> The ID passed to g_attrib_send_seq is ZERO, the command pkt will
> be added to the TAIL of the queue, and a new ID assigned to it.
> (Legacy functionality)
> 
> IF -
> The ID passed to g_attrib_send_seq is NON-ZERO, the command pkt
> will be added to the HEAD of the queue, causing it to be the next
> pkt sent to the remote device.  The NON-ZERO ID is also then able
> to cancel the command.
> 
> 
> The second RFC / PATCH is to gatt.c. It modifies the existing gatt_read_char()
> function to recognize the need for a compound Read procedure, and implements
> it as a READ_REQ + READ_BLOB_REQ + READ_BLOB_REQ ...<etc> as needed, using
> the g_attrib_send_seq() logic from the first RFC / PATCH.
> 


