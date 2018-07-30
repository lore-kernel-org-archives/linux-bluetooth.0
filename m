Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <961904947d3f021b8ed4f7a00dc1241761974060.camel@hadess.net>
References: <20180730064424.13996-1-luiz.dentz@gmail.com> <20180730064424.13996-3-luiz.dentz@gmail.com>
 <961904947d3f021b8ed4f7a00dc1241761974060.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jul 2018 13:45:32 +0300
Message-ID: <CABBYNZL8GGNkKthwOgRHmC+LmkQuG26OwvwBB4dYHWG8n-EB6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] client: Add scan.discoverable command
To: Bastien Nocera <hadess@hadess.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Jul 30, 2018 at 1:21 PM, Bastien Nocera <hadess@hadess.net> wrote:
> On Mon, 2018-07-30 at 09:44 +0300, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds discoverable command to scan menu which can be used to set
>> if adapter should become discoverable while scanning:
>>
>> [bluetooth]# scan.discoverable on
>> [bluetooth]# scan on
>> SetDiscoveryFilter success
>> [CHG] Controller XX:XX:XX:XX:XX:XX Discoverable: yes
>> Discovery started
>> [CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
>> [bluetooth]# scan off
>> Discovery stopped
>> [CHG] Controller XX:XX:XX:XX:XX:XX Discoverable: no
>
> This doesn't call SetDiscoverFilter() when the scan as already started,
> meaning that my earlier test still fails.
>
>> As mentioned on IRC, this does not work if the Discoverable filter is
>> set after the discovery has started. So:
>> discoverable off
>> scan on
>> scan.discoverable on
>> show <- this will show "Discoverable" still off.
>
> Doing a quick "scan off" / "scan on" will show "SetDiscoveryFilter
> success" appearing, this should also appear when the filter is changed
> while scanning is on-going.
>
> If you don't want to change the currently filter, it might be good for
> the client to show a "Filter change queued" or similar message that
> would show that the setting hasn't been applied, but would be for the
> next run.

Yep, I can add a message that it would be set when the scan if
enabled, in fact I don't think it is a good practice to change things
like discoverable in the middle of the discovery since may interfere
with what the controller is scheduling over the air, but since we
allow thing like UUID and RSSI it makes sense to allow everything to
be changed.



-- 
Luiz Augusto von Dentz
