Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <OF48CCDAB9.2A474A60-ONC12576F9.00324700-C12576F9.0032EEC1@LocalDomain>
References: <OF48CCDAB9.2A474A60-ONC12576F9.00324700-C12576F9.0032EEC1@LocalDomain>
Date: Fri, 2 Apr 2010 06:49:13 -0300
Message-ID: <z2o6b53b1991004020249t11eaae68u4ba5358f57bcbbe9@mail.gmail.com>
Subject: Re: Bluetooth connection from Windows to uClinux
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Danny.Wijffelaars@humiq.nl
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frank,

On Fri, Apr 2, 2010 at 6:15 AM,  <Danny.Wijffelaars@humiq.nl> wrote:
> Hey everyone,
> I'm trying to connect my windows xp pc (microsoft stack) to uClinux (bluez
> stack), via Bluetooth.
> The problem I'm having is that Windows wants a PIN for authentication, but
> I can't find a way to get uClinux to give this PIN to Windows.
> Can anybody tell me how to accomplish this?

Are you using any kind of Agent for BlueZ? In the test/ dir of bluez
sources there the simple-agent if you need one.

-- 
Gustavo F. Padovan
http://padovan.org
