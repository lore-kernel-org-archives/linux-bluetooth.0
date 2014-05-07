Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 7 May 2014 14:15:34 -0700
Message-ID: <CAGVBWjRKqY8ji=J9sacZ=VXuKFOjBCpjxTwR=0U25zmLyR-6ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Introduce Start/Stop Connection Monitor
From: Tim Song <tengs@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The ConnectionTXPower tracked here is hard to use without knowing the
maximum TX power of the controller, which can be obtained through the
same HCI command.

The device could also expose the maximum TX power as an attribute,
which can be set once on connection and does not need to be tracked
with this connection monitor API.

Regards,
Tim
