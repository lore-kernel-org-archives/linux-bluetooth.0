Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Gatt Client - RegisterApplication options
Date: Tue, 28 Jun 2016 09:24:21 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D73F131@S0MSMAIL111.arc.local>
References: <E92610C73D6DE84EB154DC52F5ECCE541D73E0E8@S0MSMAIL111.arc.local>
In-Reply-To: <E92610C73D6DE84EB154DC52F5ECCE541D73E0E8@S0MSMAIL111.arc.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I upgraded to the newest version of bluez (5.40) and noticed that the "RegisterService" method to register the services for a client application is not existing anymore.

However, I have troubles using the "RegisterApplication" method since I don't know how to put the profile hierarchy into the requested dict object. It is not clear for me, even after checking doc/gatt-api.txt and the source code.
Whatever I try results in the error message "No object received", invoked by the method
static void client_ready_cb(GDBusClient *client, void *user_data) in gatt-database.c


Can anybody help me? 

Kind regards,

Johannes