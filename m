Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 2 Mar 2015 15:41:50 -0500
Message-ID: <CAGxYWpYQ+X=B6GE8jER7hHiyQyQaLUwLz7W=WY9=_fU+pytcCA@mail.gmail.com>
Subject: RE: bt dongle goes awry after too many connections
From: Tim Tisdall <tisdall@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, the error I mentioned is called HCI_MAX_NUMBER_OF_CONNECTIONS
in the Bluez bluetooth.h file.  The name I gave it is from the
Bluetooth specs (CONNECTION_LIMIT_EXCEEDED).

- Tim
