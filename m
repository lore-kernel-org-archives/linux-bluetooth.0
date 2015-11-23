Return-Path: <szymon.janc@codecoup.pl>
Date: Mon, 23 Nov 2015 10:23:02 -0800 (PST)
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?ISO-8859-1?Q?Fran=E7ois?= Beaufort <beaufort.francois@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: Unknown Connection Identifier
Message-ID: <2045332.GytFuFKTvp@ix>
In-Reply-To: <AAC95ACC-36E4-4618-8F49-53F78AE93AA6@holtmann.org>
References: <CAEZxfGPTxwUZzU+3XSV-uiN+DMz+hyOKiiZfgF+oD6pp=-XiOA@mail.gmail.com> <AAC95ACC-36E4-4618-8F49-53F78AE93AA6@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Monday 23 November 2015 18:43:11 Marcel Holtmann wrote:
> Hi Francois,
> 
> > Would you know why I get a "Status: Unknown Connection Identifier
> > (0x02)" error while trying to connect to a BLE device, causing a
> > "Connect failed" message. However sometimes, as you can read below, it
> > is still able to connect to it.
> > 
> > Bluetooth monitor ver 5.35
> > ...
> > < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
> > [hci0] 15:36:33.367332
> > 
> >        Type: Passive (0x00)
> >        Interval: 60.000 msec (0x0060)
> >        Window: 30.000 msec (0x0030)
> >        Own address type: Public (0x00)
> >        Filter policy: Ignore not in white list (0x01)
> >> 
> >> HCI Event: Command Complete (0x0e) plen 4                           
> >> [hci0] 15:36:33.368113>> 
> >      LE Set Scan Parameters (0x08|0x000b) ncmd 1
> >      
> >        Status: Success (0x00)
> > 
> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> > [hci0] 15:36:33.368139
> > 
> >        Scanning: Enabled (0x01)
> >        Filter duplicates: Enabled (0x01)
> >> 
> >> HCI Event: Command Complete (0x0e) plen 4                           
> >> [hci0] 15:36:33.369111>> 
> >      LE Set Scan Enable (0x08|0x000c) ncmd 1
> >      
> >        Status: Success (0x00)
> >> 
> >> HCI Event: LE Meta Event (0x3e) plen 43                             
> >> [hci0] 15:36:37.636180>> 
> >      LE Advertising Report (0x02)
> >      
> >        Num reports: 1
> >        Event type: Connectable undirected - ADV_IND (0x00)
> >        Address type: Public (0x00)
> >        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
> >        Data length: 31
> >        Flags: 0x06
> >        
> >          LE General Discoverable Mode
> >          BR/EDR Not Supported
> >        
> >        Company: Anhui Huami Information Technology Co., Ltd. (343)
> >        
> >          Data: 0093590469cb1080738d253d87117136f902880f109deb42
> >        
> >        RSSI: -60 dBm (0xc4)
> > 
> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> > [hci0] 15:36:37.636249
> > 
> >        Scanning: Disabled (0x00)
> >        Filter duplicates: Disabled (0x00)
> >> 
> >> HCI Event: Command Complete (0x0e) plen 4                           
> >> [hci0] 15:36:37.637121>> 
> >      LE Set Scan Enable (0x08|0x000c) ncmd 1
> >      
> >        Status: Success (0x00)
> > 
> > < HCI Command: LE Create Connection (0x08|0x000d) plen 25
> > [hci0] 15:36:37.637198
> > 
> >        Scan interval: 60.000 msec (0x0060)
> >        Scan window: 30.000 msec (0x0030)
> >        Filter policy: White list is not used (0x00)
> >        Peer address type: Public (0x00)
> >        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
> >        Own address type: Public (0x00)
> >        Min connection interval: 50.00 msec (0x0028)
> >        Max connection interval: 70.00 msec (0x0038)
> >        Connection latency: 0x0000
> >        Supervision timeout: 420 msec (0x002a)
> >        Min connection length: 0.000 msec (0x0000)
> >        Max connection length: 0.000 msec (0x0000)
> >> 
> >> HCI Event: Command Status (0x0f) plen 4                             
> >> [hci0] 15:36:37.638083>> 
> >      LE Create Connection (0x08|0x000d) ncmd 1
> >      
> >        Status: Success (0x00)
> > 
> > < HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
> > [hci0] 15:36:39.643232
> > 
> >> HCI Event: Command Complete (0x0e) plen 4                           
> >> [hci0] 15:36:39.644088>> 
> >      LE Create Connection Cancel (0x08|0x000e) ncmd 1
> >      
> >        Status: Success (0x00)
> 
> here you are cancelling the connection attempt.
> 
> >> HCI Event: LE Meta Event (0x3e) plen 19                             
> >> [hci0] 15:36:39.646071>> 
> >      LE Connection Complete (0x01)
> >      
> >        Status: Unknown Connection Identifier (0x02)
> 
> And this results in a connect complete with the this error. It actually says
> the create connection cancel has been successful.
> 
> I think the real question is why we are ending up with the create connection
> cancel in the first place. Only 2 seconds after the connection attempt.

This is to not block other devices from connecting if pending connection takes 
too long (we can't have more than 1 pending connection).

> >        Handle: 32
> >        Role: Master (0x00)
> >        Peer address type: Public (0x00)
> >        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
> >        Connection interval: 67.50 msec (0x0036)
> >        Connection latency: 0.00 msec (0x0000)
> >        Supervision timeout: 420 msec (0x002a)
> >        Master clock accuracy: 0x00
> > 
> > @ Connect Failed: 88:0F:10:9D:EB:42 (1) status 0x02
> 
> This mgmt message might also be bug. It depends on what triggered the
> connection and the cancel action, but in general we are not tracking the
> state correctly as it seems. The message will not hurt, but I think it
> should not be here in the first place.
> 
> How are you triggering the connection?
> 
> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
pozdrawiam
Szymon Janc
