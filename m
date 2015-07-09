Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANzaTi5iskY=SpmnScctm7iTTV1CXhBimunuqezjKvVycTuSxg@mail.gmail.com>
References: <CANzaTi5iskY=SpmnScctm7iTTV1CXhBimunuqezjKvVycTuSxg@mail.gmail.com>
Date: Thu, 9 Jul 2015 15:45:20 +0300
Message-ID: <CABBYNZJwwEnyNw-D1i38xJjPsmujz+C_E5t3NqXB-G8rM8N_SQ@mail.gmail.com>
Subject: Re: Advertising api, bluez sends empty scan response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: dogan yazar <doganyazar@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jul 9, 2015 at 3:15 PM, dogan yazar <doganyazar@gmail.com> wrote:
> Hello,
> I am using Bluez 5.32 on kernel 4.1.
>
> When I run advertisement-example, bluez successfully sends
> advertisement but then as an answer to scan request it sends an empty
> scan response.
>
> Any idea what can be the problem?

Could you please add the trace, iirc BlueZ only set the scan data so
it is up to the controller to generate the scan response not the host
stack so perhaps there is something wrong with your controller.


-- 
Luiz Augusto von Dentz
