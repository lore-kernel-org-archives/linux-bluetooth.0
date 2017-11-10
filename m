Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: Re: [PATCH v2 3/7] client: Add set-advertise-{duration, timeout}
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
References: <20171102144352.32353-1-luiz.dentz@gmail.com>
 <20171102144352.32353-3-luiz.dentz@gmail.com>
Message-ID: <93ffd973-dcb0-8d19-dc12-8f959911d127@jp.fujitsu.com>
Date: Fri, 10 Nov 2017 15:40:13 +0900
MIME-Version: 1.0
In-Reply-To: <20171102144352.32353-3-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

With the latest bluez master branch, when sets a advertise timeout and
times out, bluetoothctl fails to run "advertise off" as below:

  [bluetooth]# set-advertise-duration 4
  [bluetooth]# set-advertise-timeout 4
  [bluetooth]# advertise on
  [CHG] Controller 00:09:DD:40:CA:12 SupportedInstances: 0x04
  [CHG] Controller 00:09:DD:40:CA:12 ActiveInstances: 0x01
  Advertising object registered
  [CHG] Controller 00:09:DD:40:CA:12 SupportedInstances: 0x05
  [CHG] Controller 00:09:DD:40:CA:12 ActiveInstances: 0x00
  [bluetooth]# advertise off 
  Failed to unregister advertisement: org.bluez.Error.DoesNotExist


Regards,
Eramoto

On 11/02/2017 11:43 PM, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following command which can be used to control the
> advertisement intervals:
> 
> [bluetooth]# set-advertise-duration 4
> [bluetooth]# set-advertise-timeout 4
> [bluetooth]# advertise on
> [CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x04
> [CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x01
> Advertising object registered
> [CHG] Controller B8:8A:60:D8:17:D7 SupportedInstances: 0x05
> [CHG] Controller B8:8A:60:D8:17:D7 ActiveInstances: 0x00
> ---
>  client/advertising.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  client/advertising.h |  2 ++
>  client/main.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)

