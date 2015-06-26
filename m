Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKLS-9pLxNLCJfb2OnapcX1rCqHgGoRg9gvkjnR0YcNHw@mail.gmail.com>
References: <CAPyD+=CwiwARGqT-tKomaJ+o9O6tAiMJ25TiqxFuT2DDS+VKxQ@mail.gmail.com>
	<20150625111827.6196924d@tedd-fedora-vm>
	<CAPyD+=Ao6bc4o=sDDxZ9sb4hbVShXtWTfVFzOChw4k4iGoBSJQ@mail.gmail.com>
	<CABBYNZKLS-9pLxNLCJfb2OnapcX1rCqHgGoRg9gvkjnR0YcNHw@mail.gmail.com>
Date: Fri, 26 Jun 2015 14:11:46 -0700
Message-ID: <CAPyD+=CdfYGVZHsbQvjRHTz27-nKLasOdNRpN-DoBdsNgUcWpQ@mail.gmail.com>
Subject: Re: Unreliable LE advertisement registration through BlueZ
 advertising API
From: "Othman, Ossama" <ossama.othman@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Jun 26, 2015 at 4:13 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Perhaps he is talking about missing policy, bluetooth.conf should
> contain the following:
>
>     <allow send_interface="org.bluez.GattCharacteristic1"/>
>     <allow send_interface="org.bluez.GattDescriptor1"/>
>     <allow send_interface="org.freedesktop.DBus.ObjectManager"/>
>     <allow send_interface="org.freedesktop.DBus.Properties"/>
>
>
> If it doesn't please update it and reload D-Bus service.

My bluetooth.conf was indeed out-of-date.  I didn't notice that the
bootstrap-configure script disabled data files by default, so they
didn't get installed with the rest of BlueZ.  With the correct
bluetooth.conf file in place I'm able to run example-advertisement.

Thanks!
-Ossama
