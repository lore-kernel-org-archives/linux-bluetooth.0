Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1236608040.16880.1580.camel@cookie.hadess.net>
References: <1236301226.3602.2314.camel@cookie.hadess.net>
	 <1236523586.16880.141.camel@cookie.hadess.net>
	 <2d5a2c100903090608kd4ffea6sd9b1746e2362bf2@mail.gmail.com>
	 <1236608040.16880.1580.camel@cookie.hadess.net>
Date: Mon, 9 Mar 2009 11:32:48 -0300
Message-ID: <2d5a2c100903090732x6d677dccp747c469b43906f71@mail.gmail.com>
Subject: Re: Broken SDP parsing?
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Mar 9, 2009 at 11:14 AM, Bastien Nocera <hadess@hadess.net> wrote:
> Both use the code in common/sdp-xml.[ch] and convert_sdp_record_to_xml()
> in particular, which is why it makes no sense to me...
>
> I double-checked by adding some debug to convert_raw_data_to_xml() and
> the string for the attribute I'm interested in is empty, so it must be a
> problem parsing the raw data from the device, or there's something that
> strips this value somewhere in bluetoothd...

Then I fear that my code of dumping an sdp record (sdp_copy_record) is
probably not copying the string correctly.

-- 
Luiz Augusto von Dentz
Engenheiro de Computação
