Return-Path: <cyrus@holtmann.org>
Message-ID: <524F3872.7070609@openbossa.org>
Date: Fri, 04 Oct 2013 18:51:46 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Make LE scan interval and window a controller
 option
References: <1380881955-59853-1-git-send-email-marcel@holtmann.org>
In-Reply-To: <1380881955-59853-1-git-send-email-marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 10/04/2013 07:19 AM, Marcel Holtmann wrote:
> The scan interval and window for LE passive scanning and connection
> establishment should be configurable on a per controller basis. So
> introduce a setting that later on will allow modifying it.

Each remote device has their particular set of parameters based on the 
profiles it support. So, these parameters should be per device, not per 
controller.

IIRC, we discussed about this in New Orleans and the connection 
parameters will be informed to the kernel through the Mgmt command to 
load the connection list. This way, we'll have the parameters set per 
device.

So I don't understand exactly what is the purpose of this command you 
are introducing. Am I missing something?

Regards,

Andre
