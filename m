Return-Path: <cyrus@holtmann.org>
Message-ID: <DUB118-W372AC521B8229C59C076809CF10@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: bluez-5.10/monitor/packet.c:4335: possible missing break ?
Date: Tue, 5 Nov 2013 15:02:32 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello there,

I just ran the static analysis checker "cppcheck" over the source code of bluez-5.10

It said

[monitor/packet.c:4335] -> [monitor/packet.c:4338]: (warning) Variable 'str' is reassigned a value
 before the old one has been used. 'break;' missing?

Source code is

    case 0x03:
        str = "Allow Scan Request from White List Only, "
            "Allow Connect Request from White List Only";
    default:
        str = "Reserved";
        break;

Suggest add a break statement to the 0x03 case.

Regards

David Binderman 		 	   		  