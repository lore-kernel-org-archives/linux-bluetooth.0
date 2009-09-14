Return-Path: <cyrus@holtmann.org>
From: "Zhang, Zhenhua" <zhenhua.zhang@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 14 Sep 2009 19:38:57 +0800
Subject: RE: ioctl(RFCOMMCREATEDEV) failed: File descriptor in bad state
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089A416114@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E089A4160F9@pdsmsx502.ccr.corp.intel.com>
 <1252926108.3421.5.camel@localhost.localdomain>
In-Reply-To: <1252926108.3421.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Marcel Holtmann wrote:
> Hi,
> 
>> I am calling ioctl(RFCOMMCREATEDEV) to create tty device from a
>> rfcomm fd using hands-free profile. If the HF send connection
>> request to AG and make rfcomm connect, the tty could be made
>> successfully. However, if the AG(mobile) side make request to create
>> rfcomm connection, the rfcomm could be created but fail to create
>> the tty device. The kernel returns error because socket is not
>> connected, see below code. Any idea? Thanks much! 
> 
> why do you wanna create the TTY in the first place? Going via the TTY
> layer is pretty bad idea. Don't even think about doing that. Use the
> RFCOMM socket.
> 
> Regards
> 
> Marcel

I want to create TTY and expose it to Ofono as /dev/rfcomm0. Ofono side 
could treat bluetooth connection as a TTY device, and create 
GAtChat *chat by using g_at_chat_new_from_tty(tty, syntax).

Regards,
Zhenhua
