Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: liang yu <iamyuliang@gmail.com>
Date: Wed, 17 Nov 2010 11:43:19 +0800
Message-ID: <AANLkTikTyH+3LLbr=ytu+9jcE8Sk_wTqdRyn9jwK821a@mail.gmail.com>
Subject: Does OBEX authentication works in OPP?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all:
     I am not sure it is the right place to ask the question.
According to the Bluetooth SIG profile OBEX authentication is not used
in OPP. But in source code of Obexd-0.36/plugins/opp.c, the function
opp_chkput invokes manager_request_authorization. Does this mean that
in your implementation it is still checked OBEX authentication in opp?
    Doea anybody give me some tips.
    Thanks advance.

Best regards
