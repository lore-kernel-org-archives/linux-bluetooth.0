Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Jun 2012 11:06:18 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCHv2 3/5] Bluetooth: Add opcode to error message
Message-ID: <20120611080611.GA29187@aemeltch-MOBL1>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1339153405-12070-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1339153405-12070-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <201206081317.42898.szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201206081317.42898.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 08, 2012 at 01:17:42PM +0200, Szymon Janc wrote:
> > -	BT_ERR("%s command tx timeout", hdev->name);
> > +	if (hdev->sent_cmd) {
> > +		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
> > +		u16 opcode = __le16_to_cpu(sent->opcode);
> > +
> > +		BT_ERR("%s command 0x%4.4x tx timeout", hdev->name, opcode);
> > +	} else
> > +		BT_ERR("%s command tx timeout", hdev->name);
> > +
> 
> Just a minor, 'else' should have braces as well.

Sure, thanks for pointing out. I will send updated version soon.

Best regards 
Andrei Emeltchenko 

