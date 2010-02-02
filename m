Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Feb 2010 15:16:12 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: nirav rabara <niravrabara@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Kernel panic when SCO connection
Message-ID: <20100202171612.GA7034@vigoh>
References: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <912bb79a1002020858lda468aci6fef3e73fac07bd6@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nirav,

* nirav rabara <niravrabara@gmail.com> [2010-02-02 22:28:53 +0530]:

> Hi,
> When I try to connect SCO socket, Kernel getting crash.
> Linux kernel - 2.6.22
> Bluez - 4.58

Please try a 2.6.33 kernel and tell us if the bug still happens.

> 
> error message,
> __tx_submit:hci0 tx submit failed urb c0552c14 type 3 err -19
> 
> sometimes in connection is showing error while connection as below,
> hci_acldata_packet:hci0 ACL packet data for unknown connection handler 2
> 
> It would be really appreciable if  somebody put some on light on this
> issue, OR suggest me any patch or documentation.
> 
> -- 
> With Regards,
> Nirav Rabara
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Gustavo F. Padovan
http://padovan.org

ProFUSION embedded systems - http://profusion.mobi
