Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <001601cf7436$ad7c6360$08752a20$@samsung.com>
References: <001601cf7436$ad7c6360$08752a20$@samsung.com>
Date: Tue, 20 May 2014 18:29:15 +0300
Message-ID: <CABBYNZLMrj__0xcj624De3fo9BT1tX-a6cWWYgXKwwqcPFmLzw@mail.gmail.com>
Subject: Re: ATT/GATT parsing to hcidump
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, p.sinha@samsung.com,
	bharat.panda@samsung.com, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 20, 2014 at 5:20 PM, Vikrampal <vikram.pal@samsung.com> wrote:
> Hi All,
>
> Being new to BlueZ community, I went through BlueZ's TODO items.
> To get started, I've selected the below TODO item as my maiden contribution.
>
> - ATT/GATT parsing to hcidump. Partially implemented, missing to fix
> multiple advertises in the same event and RSSI
>
> Please provide me your valuable suggestion for the same. Thanks!


We should probably update the TODO about hcidump, the plans are to
move the parsers to btmon and deprecate hcidump so there is a _LOT_
work in to be done in that area.
