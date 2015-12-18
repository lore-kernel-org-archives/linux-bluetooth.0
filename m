Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1] lib: Update company identifiers
Date: Fri, 18 Dec 2015 15:01:38 +0530
Message-id: <1450431098-22338-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index d48d844..d6e71a2 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -1635,6 +1635,118 @@ const char *bt_compidtostr(int compid)
 		return "Rx Networks, Inc.";
 	case 686:
 		return "WeatherFlow, Inc.";
+	case 687:
+		return "Technicolor USA Inc.";
+	case 688:
+		return "Bestechnic(Shanghai),Ltd";
+	case 689:
+		return "Raden Inc";
+	case 690:
+		return "JouZen Oy";
+	case 691:
+		return "CLABER S.P.A.";
+	case 692:
+		return "Hyginex, Inc.";
+	case 693:
+		return "HANSHIN ELECTRIC RAILWAY CO.,LTD.";
+	case 694:
+		return "Schneider Electric";
+	case 695:
+		return "Oort Technologies LLC";
+	case 696:
+		return "Chrono Therapeutics";
+	case 697:
+		return "Rinnai Corporation";
+	case 698:
+		return "Swissprime Technologies AG";
+	case 699:
+		return "Koha.,Co.Ltd";
+	case 700:
+		return "Genevac Ltd";
+	case 701:
+		return "Chemtronics";
+	case 702:
+		return "Seguro Technology Sp. z o.o.";
+	case 703:
+		return "Redbird Flight Simulations";
+	case 704:
+		return "Dash Robotics";
+	case 705:
+		return "LINE Corporation";
+	case 706:
+		return "Guillemot Corporation";
+	case 707:
+		return "Techtronic Power Tools Technology Limited";
+	case 708:
+		return "Wilson Sporting Goods";
+	case 709:
+		return "Lenovo (Singapore) Pte Ltd. ( 联想（新加坡） )";
+	case 710:
+		return "Ayatan Sensors";
+	case 711:
+		return "Electronics Tomorrow Limited";
+	case 712:
+		return "VASCO Data Security International, Inc.";
+	case 713:
+		return "PayRange Inc.";
+	case 714:
+		return "ABOV Semiconductor";
+	case 715:
+		return "AINA-Wireless Inc.";
+	case 716:
+		return "Eijkelkamp Soil & Water";
+	case 717:
+		return "BMA ergonomics b.v.";
+	case 718:
+		return "Teva Branded Pharmaceutical Products R&D, Inc.";
+	case 719:
+		return "Anima";
+	case 720:
+		return "3M";
+	case 721:
+		return "Empatica Srl";
+	case 722:
+		return "Afero, Inc.";
+	case 723:
+		return "Powercast Corporation";
+	case 724:
+		return "Secuyou ApS";
+	case 725:
+		return "OMRON Corporation";
+	case 726:
+		return "Send Solutions";
+	case 727:
+		return "NIPPON SYSTEMWARE CO.,LTD.";
+	case 728:
+		return "Neosfar";
+	case 729:
+		return "Fliegl Agrartechnik GmbH";
+	case 730:
+		return "Gilvader";
+	case 731:
+		return "Digi International Inc (R)";
+	case 732:
+		return "DeWalch Technologies, Inc.";
+	case 733:
+		return "Flint Rehabilitation Devices, LLC";
+	case 734:
+		return "Samsung SDS Co., Ltd.";
+	case 735:
+		return "Blur Product Development";
+	case 736:
+		return "University of Michigan";
+	case 737:
+		return "Victron Energy BV";
+	case 738:
+		return "NTT docomo";
+	case 739:
+		return "Carmanah Technologies Corp.";
+	case 740:
+		return "Bytestorm Ltd.";
+	case 741:
+		return "Espressif Incorporated ( 乐鑫信息科技(上海)有限公司 )";
+	case 742:
+		return "Unwire";
 	case 65535:
 		return "internal use";
 	default:
-- 
1.9.1

