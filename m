Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTiklu7yRsbmNbOgSW2b4LobLlguxnJxxMpi_k_sp@mail.gmail.com>
References: <AANLkTiklu7yRsbmNbOgSW2b4LobLlguxnJxxMpi_k_sp@mail.gmail.com>
Date: Thu, 13 May 2010 15:02:09 +0800
Message-ID: <AANLkTimlmVEbjcc79zqkQmOcr8_kU7P2QBGROjBaZxUI@mail.gmail.com>
Subject: Re: FTP problem during obexd initialization?
From: Simon <simonchan1979@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=GB2312
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Most probably some other obex instance has occupied the same address,
eg. obex-data-server.
Thanks£¡

2010/5/13 Daniel Abraham <daniel.shrugged@gmail.com>:
> Whenever I start obexd 0.23 (on Fedora 12 with BlueZ 4.64) with the -f
> argument (FTP), I see the following log message:
>
> "obexd[...]: Bluetooth server register failed: rfcomm_bind: Address
> already in use (98)"
>
> happens only with FTP, and regardless whether I specify other
> protocols (e.g. e/o/p/s).
>
> Is that indicative or a real problem, or just a harmless log message?
>
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
