Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 24 Apr 2013 22:26:51 +0800
Message-ID: <CANO4cTXS29CjmK_NqMWj-XcVV37hMDcqiJ8f5cE+bmBD2ChD+w@mail.gmail.com>
Subject: Problem of responding to an RFCOMM NSC command
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Sorry for posting this question into the list. However, I am thinking
this question might be worth confirming with developers. This happens
when testing IUT as RFCOMM responder for the Bluetooth SIG test plan
RFCOMM: TP/RFC/BV-23-C. From the angel of protocol test result, the
current implementation fails because the IUT ignores or responds with
an incorrect response. In detail, there'll be two cases where the
software will have a problem.

1. For command == RFCOMM_NSC and  C/R bit = 1 (command), the function
rfcomm_recv_mcc() will simply ignore and send no response. It seems
the test plan requires a response a NSC response.

2. For command is not one of RFCOMM_NSC, RFCOMM_TEST, RFCOMM_FCON,
RFCOMM_FCOFF, RFCOMM_MSC, RFCOMM_RLS, RFCOMM_RPN and RFCOMM_PN, the
function rfcomm_recv_mcc() will not ignore but call rfcomm_send_nsc(s,
cr, type) to respond with a NSC. However, when calling
rfcomm_send_nsc, parameter cr is set to 0x02 which is extracted by
__test_cr(). Then rfcomm_send_nsc() will use macro __mcc_type to
re-assemble the byte by shifting it by 1 bit.

#define __test_cr(b)      ((b & 0x02))  // line 81
#define __mcc_type(cr, type)   (((type << 2) | (cr << 1) | 0x01))  // line 94

This causes the C/R flag (which is already at right bit from
__test_cr()) to be shifted by one more bit from bit 2 to bit 3.

3. For both case 1 and 2, another common problem is when
rfcomm_send_nsc() re-assembles the response, at line 847, the first
call to __mcc_type may be called with cr=0 because it's trying to give
a response.

Anyway, all of them are just my opinions based on analysis on current
version(both bluetooth.git and bluetooth-next.git) and one or more
could be wrong. So I am wondering before I post a patch, could anyone
confirm they're valid problems?

Thanks,
Tim
