Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ckNXhrC=QF9+CcfA_H-iMGM9kdG+GgjaZ3RZL=nx9cQ@mail.gmail.com>
References: <CAEZxfGOFqWkC84Yq9emU76WYqBY-0rGhgGEEBQ_dCr1XTTk2CQ@mail.gmail.com>
 <CABBYNZ+ckNXhrC=QF9+CcfA_H-iMGM9kdG+GgjaZ3RZL=nx9cQ@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Mon, 30 Nov 2015 10:23:57 +0100
Message-ID: <CAEZxfGP5LegWOJnadm9dS8vxOMOxEnB_uNxAsdMZknXUuzNP0A@mail.gmail.com>
Subject: Re: Add name and namePrefix filter to SetDiscoveryFilter
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

You're right.
As discussed on a separate thread with Jakub, instead of two filters
we might want to add one unique filter "nameRegexp" that would take a
regular expression to filter against bluetooth device names.
What do you think?

On Mon, Nov 30, 2015 at 9:40 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi François,
>
> On Tue, Nov 24, 2015 at 2:09 PM, François Beaufort
> <beaufort.francois@gmail.com> wrote:
> > The SetDiscoveryFilter method already has UUIDs, RSSI, Pathloss and
> > Transport filters.
> > I was wondering if it would be possible to add "name" and "namePrefix"
> > filters to this list?
> >
> > I'm shamelessly asking this because the Web Bluetooth API has added
> > these filters: http://webbluetoothcg.github.io/web-bluetooth/#dictdef-bluetoothscanfilter
>
> I guess we can extend with more filters but Im afraid having 2 filters
> like that can be confusing, what if name and prefix are set? Shall it
> can an error? What should be the logic AND or OR operation? I guess
> like with the other we need a merge strategy if multiple clients set a
> filter with different names.
>
>
>
> --
> Luiz Augusto von Dentz
