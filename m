Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Oct 2015 16:44:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] monitor/avctp: Decode player features
Message-ID: <20151012144436.GA1772@t440s>
References: <1444659847-1725-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444659847-1725-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Oct 12, 2015, Luiz Augusto von Dentz wrote:
> This decodes the bits related to browsing channel which is useful to
> debug:
> 
> > ACL Data RX: Handle 256 flags 0x02 dlen 68
>       Channel: 69 len 64 ctrl 0x0100 [PSM 27 mode 3] {chan 5}
>       I-frame: Unsegmented TxSeq 0 ReqSeq 1
>       AVCTP Browsing: Response: type 0x00 label 0 PID 0x110e
>         AVRCP: GetFolderItems: len 0x0036
>           Status: 0x04 (Success)
>           UIDCounter: 0x0000 (0)
>           NumOfItems: 0x0001 (1)
>           Item: 0x01 (Media Player)
>           Length: 0x002e (46)
>           PlayerID: 0x0001 (1)
>           PlayerType: 0x0001 (Audio)
>           PlayerSubType: 0x00000000 (None)
>           PlayStatus: 0x01 (PLAYING)
>           Features: 0x00000000003700050000000000000000
>             Advanced Control Player: yes
>             Browsing: no
>             Searching: no
>             AddToNowPlaying: no
>             Unique UIDs: no
>             OnlyBrowsableWhenAddressed: no
>             OnlySearchableWhenAddressed: no
>             NowPlaying: no
>             UIDPersistency: no

I think we want to have this consistent with how it's represented for
other similar supported bits in btmon (e.g. HCI-level features), i.e.
only list the ones supported and print in red any unknown bits.

Johan
