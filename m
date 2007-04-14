Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d9a6586e0704141357o47b472f6iba0b7d53c02b5e66@mail.gmail.com>
Date: Sat, 14 Apr 2007 13:57:08 -0700
From: "Shawn Rutledge" <shawn.t.rutledge@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BAY103-F224E09EECA0E11C403D8A5DA5C0@phx.gbl>
MIME-Version: 1.0
References: <BAY103-F224E09EECA0E11C403D8A5DA5C0@phx.gbl>
Subject: Re: [Bluez-devel] handy as bluetooth headset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

The idea is to use it _with_ a headset (which will connect to HF
gateway service), not _as_ a headset.  You keep your phone in your
pocket and stick the headset in your ear and can make hands-free
calls.  Or use it with a car handsfree kit to do the same on your car
stereo.  The phone acts as a "gateway" to connect your headset to the
GSM phone service.

Headset profile is different, and unusual for a cell phone to have.
It's mostly for wireless office phone headsets, AFAIK.

BTW the w810i has good AT-command phonebook support, if you are using
it with a handsfree kit with that feature.  It's one of the few that
for dialed, received and missed calls, will give you the date and time
of the call.

On 4/14/07, X Cite <getxcite@hotmail.com> wrote:
> hi bluez developers!
> i wanna know if it's possible to use my sony ericsson w810i handy as a
> bt-headset!
>
>
> Service Name: HF Voice Gateway  <-- this sounds good
> Service RecHandle: 0x10004
> Service Class ID List:
>   "Handfree Audio Gateway" (0x111f)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 4
> Profile Descriptor List:
>   "Handsfree" (0x111e)
>     Version: 0x0101
>
> Service Name: HS Voice Gateway  <--- this too
> Service RecHandle: 0x10005
> Service Class ID List:
>   "Headset Audio Gateway" (0x1112)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 5
> Profile Descriptor List:
>   "Headset" (0x1108)
>     Version: 0x0100

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
