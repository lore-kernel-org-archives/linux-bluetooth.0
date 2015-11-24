Return-Path: <beaufort.francois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2045332.GytFuFKTvp@ix>
References: <CAEZxfGPTxwUZzU+3XSV-uiN+DMz+hyOKiiZfgF+oD6pp=-XiOA@mail.gmail.com>
 <AAC95ACC-36E4-4618-8F49-53F78AE93AA6@holtmann.org> <2045332.GytFuFKTvp@ix>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 24 Nov 2015 10:24:23 +0100
Message-ID: <CAEZxfGOdyZat1evKm0Jfwg=knuigGdfK_wVqS8NG=zFAY3aRXg@mail.gmail.com>
Subject: Re: Unknown Connection Identifier
To: Szymon Janc <szymon.janc@codecoup.pl>, Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks both of you for your input.

Here are my 100% reproducible steps:
- Restart bluetoothd to start fresh
- Remove cached device (remove 88:0F:10:9D:EB:42)
- Run basic scan (scan on)
- Wait for the device to pop up in results and stop scan (scan off)
- Try to connect to it (connect 88:0F:10:9D:EB:42)

As you can read below I now have 2 "LE Connection Complete (0x01)" events.

Bluetooth monitor ver 5.35
= New Index: A4:17:31:78:A6:04 (BR/EDR,USB,hci0)
                [hci0] 0.624321
< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
               [hci0] 11.038826
        Address type: Public (0x00)
        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 11.040084
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
               [hci0] 11.040125
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 11.041085
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
               [hci0] 11.041134
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 11.042084
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 43                                             [hci0] 15.668141
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Data length: 31
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Anhui Huami Information Technology Co., Ltd. (343)
          Data: 00f70b676930f4c909f4a5acd792a299ff02880f109deb42
        RSSI: -59 dBm (0xc5)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
               [hci0] 15.668289
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 15.669062
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
               [hci0] 15.669171
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                             [hci0] 15.670065
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
               [hci0] 17.670566
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 17.672048
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                             [hci0] 17.674036
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 32
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Connect Failed: 88:0F:10:9D:EB:42 (1) status 0x02
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
               [hci0] 17.687564
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 17.689036
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
               [hci0] 17.689118
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 17.690036
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 43                                             [hci0] 18.672125
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Data length: 31
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Company: Anhui Huami Information Technology Co., Ltd. (343)
          Data: 00f70b676930f4c909f4a5acd792a299ff02880f109deb42
        RSSI: -62 dBm (0xc2)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
               [hci0] 18.672266
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 18.673040
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
               [hci0] 18.673161
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                             [hci0] 18.674040
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
               [hci0] 20.678576
> HCI Event: Command Complete (0x0e) plen 4                                           [hci0] 20.680062
      LE Create Connection Cancel (0x08|0x000e) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                             [hci0] 20.682048
      LE Connection Complete (0x01)
        Status: Unknown Connection Identifier (0x02)
        Handle: 32
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Connect Failed: 88:0F:10:9D:EB:42 (1) status 0x02

On Mon, Nov 23, 2015 at 7:23 PM Szymon Janc <szymon.janc@codecoup.pl> wrote:
>
> Hi,
>
> On Monday 23 November 2015 18:43:11 Marcel Holtmann wrote:
> > Hi Francois,
> >
> > > Would you know why I get a "Status: Unknown Connection Identifier
> > > (0x02)" error while trying to connect to a BLE device, causing a
> > > "Connect failed" message. However sometimes, as you can read below, it
> > > is still able to connect to it.
> > >
> > > Bluetooth monitor ver 5.35
> > > ...
> > > < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
> > > [hci0] 15:36:33.367332
> > >
> > >        Type: Passive (0x00)
> > >        Interval: 60.000 msec (0x0060)
> > >        Window: 30.000 msec (0x0030)
> > >        Own address type: Public (0x00)
> > >        Filter policy: Ignore not in white list (0x01)
> > >>
> > >> HCI Event: Command Complete (0x0e) plen 4
> > >> [hci0] 15:36:33.368113>>
> > >      LE Set Scan Parameters (0x08|0x000b) ncmd 1
> > >
> > >        Status: Success (0x00)
> > >
> > > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> > > [hci0] 15:36:33.368139
> > >
> > >        Scanning: Enabled (0x01)
> > >        Filter duplicates: Enabled (0x01)
> > >>
> > >> HCI Event: Command Complete (0x0e) plen 4
> > >> [hci0] 15:36:33.369111>>
> > >      LE Set Scan Enable (0x08|0x000c) ncmd 1
> > >
> > >        Status: Success (0x00)
> > >>
> > >> HCI Event: LE Meta Event (0x3e) plen 43
> > >> [hci0] 15:36:37.636180>>
> > >      LE Advertising Report (0x02)
> > >
> > >        Num reports: 1
> > >        Event type: Connectable undirected - ADV_IND (0x00)
> > >        Address type: Public (0x00)
> > >        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
> > >        Data length: 31
> > >        Flags: 0x06
> > >
> > >          LE General Discoverable Mode
> > >          BR/EDR Not Supported
> > >
> > >        Company: Anhui Huami Information Technology Co., Ltd. (343)
> > >
> > >          Data: 0093590469cb1080738d253d87117136f902880f109deb42
> > >
> > >        RSSI: -60 dBm (0xc4)
> > >
> > > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> > > [hci0] 15:36:37.636249
> > >
> > >        Scanning: Disabled (0x00)
> > >        Filter duplicates: Disabled (0x00)
> > >>
> > >> HCI Event: Command Complete (0x0e) plen 4
> > >> [hci0] 15:36:37.637121>>
> > >      LE Set Scan Enable (0x08|0x000c) ncmd 1
> > >
> > >        Status: Success (0x00)
> > >
> > > < HCI Command: LE Create Connection (0x08|0x000d) plen 25
> > > [hci0] 15:36:37.637198
> > >
> > >        Scan interval: 60.000 msec (0x0060)
> > >        Scan window: 30.000 msec (0x0030)
> > >        Filter policy: White list is not used (0x00)
> > >        Peer address type: Public (0x00)
> > >        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
> > >        Own address type: Public (0x00)
> > >        Min connection interval: 50.00 msec (0x0028)
> > >        Max connection interval: 70.00 msec (0x0038)
> > >        Connection latency: 0x0000
> > >        Supervision timeout: 420 msec (0x002a)
> > >        Min connection length: 0.000 msec (0x0000)
> > >        Max connection length: 0.000 msec (0x0000)
> > >>
> > >> HCI Event: Command Status (0x0f) plen 4
> > >> [hci0] 15:36:37.638083>>
> > >      LE Create Connection (0x08|0x000d) ncmd 1
> > >
> > >        Status: Success (0x00)
> > >
> > > < HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
> > > [hci0] 15:36:39.643232
> > >
> > >> HCI Event: Command Complete (0x0e) plen 4
> > >> [hci0] 15:36:39.644088>>
> > >      LE Create Connection Cancel (0x08|0x000e) ncmd 1
> > >
> > >        Status: Success (0x00)
> >
> > here you are cancelling the connection attempt.
> >
> > >> HCI Event: LE Meta Event (0x3e) plen 19
> > >> [hci0] 15:36:39.646071>>
> > >      LE Connection Complete (0x01)
> > >
> > >        Status: Unknown Connection Identifier (0x02)
> >
> > And this results in a connect complete with the this error. It actually says
> > the create connection cancel has been successful.
> >
> > I think the real question is why we are ending up with the create connection
> > cancel in the first place. Only 2 seconds after the connection attempt.
>
> This is to not block other devices from connecting if pending connection takes
> too long (we can't have more than 1 pending connection).
>
> > >        Handle: 32
> > >        Role: Master (0x00)
> > >        Peer address type: Public (0x00)
> > >        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
> > >        Connection interval: 67.50 msec (0x0036)
> > >        Connection latency: 0.00 msec (0x0000)
> > >        Supervision timeout: 420 msec (0x002a)
> > >        Master clock accuracy: 0x00
> > >
> > > @ Connect Failed: 88:0F:10:9D:EB:42 (1) status 0x02
> >
> > This mgmt message might also be bug. It depends on what triggered the
> > connection and the cancel action, but in general we are not tracking the
> > state correctly as it seems. The message will not hurt, but I think it
> > should not be here in the first place.
> >
> > How are you triggering the connection?
> >
> > Regards
> >
> > Marcel
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> pozdrawiam
> Szymon Janc
