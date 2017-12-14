Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1530610.7dBsjPVAZJ@ix>
References: <CADU0Vqxge=ESPPT3YWPt9VCRZCCX=VM5AHBYVnVQsKP3_mveiA@mail.gmail.com>
 <CADU0VqxBm3dv3oMsvMLqQ_h0EqwQpekJsVT6RkZZ_buiK_db_w@mail.gmail.com> <1530610.7dBsjPVAZJ@ix>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Dec 2017 14:08:21 -0200
Message-ID: <CABBYNZ+8h5Q7HCevDAxOAC7RUaOvY9qK1sM_NGNt5RzLXSahJA@mail.gmail.com>
Subject: Re: Profile1 close question
To: Szymon Janc <szymon.janc@codecoup.pl>
Cc: John Klug <ski.brimson@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Thu, Dec 14, 2017 at 1:35 PM, Szymon Janc <szymon.janc@codecoup.pl> wrote:
> Hi John,
>
> On Thursday, 14 December 2017 16:21:32 CET John Klug wrote:
>> What is holding the connection open is bluetoothd.
>>
>> After closing the file descriptor for RFCOMM, there are two file
>> descriptors in the Bluetooth daemon that are left:
>>
>> bluetooth 1406 root   18u     sock        0,7      0t0 26587 protocol:
>> RFCOMM bluetooth 1406 root   19u     sock        0,7      0t0 26602
>> protocol: RFCOMM
>>
>> By terminating the application these go away, but what if I wish to
>> keep the daemon running?  How do I tell the Bluetooth daemon to close
>> the RFCOMM sockets?
>
> I think you need to shutdown() socket.

Yep, shutdown must be used since bluetoothd keeps a reference in case
it has to disconnect and to keep track of the service state. We should
perhaps document that we expect the user application to shutdown the
fd in case it want it to be disconnected.

-- 
Luiz Augusto von Dentz
