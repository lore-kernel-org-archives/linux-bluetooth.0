Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Nov 2012 15:31:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Koustuv Ghosh <koustuvg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: OPP test program
Message-ID: <20121129133148.GA30257@x220.ger.corp.intel.com>
References: <CAB6wy+b4GD8XSNHceEPm-UFdcm4=4nrrZtoPMr+aABu2D7tOvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB6wy+b4GD8XSNHceEPm-UFdcm4=4nrrZtoPMr+aABu2D7tOvw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Koustuv,

On Thu, Nov 29, 2012, Koustuv Ghosh wrote:
> I have seen there is no OPP client or server,  test program in bluez
> release. Although obxd projects provides it separately using python
> script+ dbus mechanism.
> 
> In my case , I have developed a simple command line OPP client
> program( takes the remote BD Address and path of the file as arguments
> ) which gets compilied with bluez itself. This test progrm can also be
> interfaced with Dbus.
> 
> Is it allowable that if I want to contribute this test program to
> community , obviously by flowing community protocol.

BlueZ hasn't traditionally had any OBEX code. This has been taken care
of by a separate project called obexd and you can find both release
announcements of it as well as its git tree in the same place you can
find BlueZ. The obexd project has both client and server implementations
for most of the known OBEX-based profiles, including OPP. It's worth
noting thought that starting with BlueZ 5 will will merge the obexd tree
into the BlueZ one any new obexd releases will come together with the
usual BlueZ 5.x releases.

Johan
