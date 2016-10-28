Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHY_EhVGVeoE+Ljw_rm+k6LnYC0=ySDsn3qYay3gJ_vM8u7WXw@mail.gmail.com>
References: <CAHY_EhVGVeoE+Ljw_rm+k6LnYC0=ySDsn3qYay3gJ_vM8u7WXw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 28 Oct 2016 11:55:02 +0300
Message-ID: <CABBYNZJauZSboT+PvdwQ7EGwLMnwDE3ghGjRioBppCfyemsD2w@mail.gmail.com>
Subject: Re: obexd MAP/MNS
To: Jason Gauthier <jagauthier@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jason,

On Fri, Oct 28, 2016 at 7:09 AM, Jason Gauthier <jagauthier@gmail.com> wrote:
> Hello,
>
>    In Python, I've been successful interfacing with PBAP, and recently
> MAP.  Ultimately, though, my goal is to receive new message
> notifications using MNS part of MAP.
>
> I've read the Bluetooth document on MAP (section 6), and I've seen a
> few requests around, but I am not sure how to implement this.
>
> Does anyone have any python examples, or documentation, on how this is
> implemented?

Check obexctl under tools, when a notification arrive it will create
an object implementing interface org.bluez.obex.Message1 which you can
subscribe with InterfacesAdded signal from ObjectManager.

-- 
Luiz Augusto von Dentz
