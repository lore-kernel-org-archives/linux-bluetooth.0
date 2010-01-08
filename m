Return-Path: <cyrus@holtmann.org>
Subject: pairing on hci level with pin
From: Alejandro von Mankowski <alejandro@vonmankowski.de>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jan 2010 10:45:53 +0100
Message-ID: <1262943953.2595.56.camel@alejandro-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm currently working on a home project about data transmission over
bluetooth with pin-pairing. I've learned how to get rfcomm-connection
established and work. The pin has to be hard coded in the program,
because it is an embedded system and there won't be a user interaction.

But when I come to implement pairing with pin, what hci_request do I
have to send to get the devices to pair?
Another question that I couldn't resolve is the purpose of the pin_type
variable. What is it for?

Best regards,

Alejandro

