Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAOT_U5abUJeZuB4-e1T1qQF82rk4W07HVGBN0hPLVqC6TJCJbg@mail.gmail.com>
References: <CAAvkfd_baAUHfnO9JX3h2rc4BYQBzjBeWqf2tiGBMJQMG2yseA@mail.gmail.com>
 <CAOT_U5bOS63BbqoyLPhTQ_z4ve0u+obLFg8HENyMYxik00+oWA@mail.gmail.com>
 <CAAvkfd8izSkCW7-1a_PedkY9Ceo+eDOK3V-Kxz63fR5DGaVHFQ@mail.gmail.com> <CAOT_U5abUJeZuB4-e1T1qQF82rk4W07HVGBN0hPLVqC6TJCJbg@mail.gmail.com>
From: David Frey <dpfrey@gmail.com>
Date: Thu, 29 Mar 2018 11:43:33 -0700
Message-ID: <CAAvkfd8x62XYByNpTxSNg4x4HhX-WaNdLnrojueabQJLrCZycw@mail.gmail.com>
Subject: Re: Support adapter without HCI
To: Alan Martinovic <alan.martinovic@senic.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> > There is a closed source BLE library that
> > exposes GATT and GAP functions.
>
> Can you expand on the definition on "exposes" here?
> From where to whom?

What I meant was that there is a C API exposed by a library on the
microcontroller for doing GATT and GAP.  In order to allow Linux to
make use of this library, I will need to provide some sort of RPC
protocol over SPI or UART.
